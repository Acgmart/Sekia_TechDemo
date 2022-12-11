//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Dissolve_4Texs_VertexAni" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_AlphaEdgeFade ("AlphaEdgeFade", Float) = 4
_BaseTex ("BaseTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _BaseTexColorChannelSwitch ("BaseTexColorChannelSwitch", Float) = 1
[Enum(R,0,G,1,B,2,A,3,White,4)] _BaseTexAlphaChannelSwitch ("BaseTexAlphaChannelSwitch", Float) = 3
_BaseTex_Uspeed ("BaseTex_Uspeed", Float) = 0
_BaseTex_Vspeed ("BaseTex_Vspeed", Float) = 0
_LerpColorDark ("LerpColorDark", Color) = (1,1,1,1)
_LerpColorLight ("LerpColorLight", Color) = (1,1,1,1)
_LerpAlphaScaler ("LerpAlphaScaler", Range(0, 20)) = 1
[MHYToggle] _UseCustom2ColorToggle ("UseCustom2ColorToggle", Float) = 0
_DissolveTex ("DissolveTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _DissolveTexChannelSwitch ("DissolveTexChannelSwitch", Float) = 0
_DissolveTex_Uspeed ("DissolveTex_Uspeed", Float) = 0
_DissolveTex_Vspeed ("DissolveTex_Vspeed", Float) = 0
[MHYToggle] _DissolveTexUVRandomToggle ("DissolveTexUVRandomToggle", Float) = 0
[Toggle(_NOISETEXTOGGLEONBASETEX_ON)] _NoiseTexToggleOnBaseTex ("NoiseTex[Toggle]OnBaseTex", Float) = 0
[Toggle(_NOISETEXTOGGLE_ON)] _NoiseTexToggle ("NoiseTex[Toggle]", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _NoiseTexChannelSwitch ("NoiseTexChannelSwitch", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 0
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 0
_Noise_Offset ("Noise_Offset", Float) = 0.5
_Noise_Brightness ("Noise_Brightness", Float) = 0.2
[MHYToggle] _NoiseTexUVRandomToggle ("NoiseTexUVRandomToggle", Float) = 0
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTex[Toggle]", Float) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskTexChannelSwitch ("MaskTexChannelSwitch", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DistortionTexRG ("DistortionTex(RG)", 2D) = "white" { }
_DistortionTexRG_Uspeed ("DistortionTex(RG)_Uspeed", Float) = 0
_DistortionTexRG_Vspeed ("DistortionTex(RG)_Vspeed", Float) = 0
_DistortionRScaler ("DistortionRScaler", Float) = 2
_DistortionGScaler ("DistortionGScaler", Float) = 2
_DistortionMaskTex ("DistortionMaskTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _DistortionMaskChannelToggle ("DistortionMaskChannelToggle", Float) = 2
_ParticleCustomProp0 ("_ParticleCustomProp0", Vector) = (1,1,1,1)
_DistortionOpacity ("DistortionOpacity", Float) = 0.5
_ParticleCustomProp1 ("_ParticleCustomProp1", Vector) = (1,1,1,1)
_VertexAniNoiseTex ("VertexAniNoiseTex", 2D) = "white" { }
_VertexAniNoiseMaskTex ("VertexAniNoiseMaskTex", 2D) = "white" { }
_VertexAniNoiseUVPannerXY ("VertexAniNoiseUVPanner(XY)", Vector) = (0,0,0,0)
_VertexAniNoiseTexSubtract ("VertexAniNoiseTexSubtract", Float) = 0
_VertexAniNosieChannelNum ("VertexAniNosieChannelNum", Range(-4, 4)) = 1
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_DayColor ("DayColor", Color) = (1,1,1,1)
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
  GpuProgramID 55048
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8.x;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb5.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_13.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_13.xy = (u_xlatb1.x) ? u_xlat16_13.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_13.xy);
    u_xlat16_13.x = (u_xlatb5.x) ? u_xlat2.w : 0.0;
    u_xlat16_13.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_13.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_13.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_13.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat16_13.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_8.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_8.x = (u_xlatb5.y) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat16_13 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_13;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_5.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_5.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_9.x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump vec2 u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb6.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_15.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = (u_xlatb1.x) ? u_xlat16_15.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
    u_xlat16_15.x = (u_xlatb6.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_15.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_15.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_9.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15.x = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_9.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_9.x + vs_TEXCOORD0.z, u_xlat16_9.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_9.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_9.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_9.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_9.x = (u_xlatb6.y) ? u_xlat2.w : 0.0;
    u_xlat16_9.x = (u_xlatb6.x) ? u_xlat2.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_9.x;
    u_xlat16_15 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_15;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8.x;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb5.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_13.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_13.xy = (u_xlatb1.x) ? u_xlat16_13.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_13.xy);
    u_xlat16_13.x = (u_xlatb5.x) ? u_xlat2.w : 0.0;
    u_xlat16_13.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_13.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_13.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_13.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat16_13.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_8.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_8.x = (u_xlatb5.y) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat16_13 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_13;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_5.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_5.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_9.x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump vec2 u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb6.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_15.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = (u_xlatb1.x) ? u_xlat16_15.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
    u_xlat16_15.x = (u_xlatb6.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_15.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_15.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_9.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15.x = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_9.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_9.x + vs_TEXCOORD0.z, u_xlat16_9.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_9.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_9.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_9.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_9.x = (u_xlatb6.y) ? u_xlat2.w : 0.0;
    u_xlat16_9.x = (u_xlatb6.x) ? u_xlat2.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_9.x;
    u_xlat16_15 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_15;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec2 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
mediump float u_xlat16_23;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb4.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_2.xyz = (u_xlatb4.x) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_23 = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_23 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_23;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb3.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb4.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb4.y) ? u_xlat0.w : 0.0;
    u_xlat16_5.x = (u_xlatb4.x) ? u_xlat0.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_23 = u_xlat16_23 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_23 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_2.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
mediump vec2 u_xlat16_18;
float u_xlat19;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb5)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_24;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_18.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlat16_4.xy = (u_xlatb2.y) ? u_xlat16_18.xy : u_xlat16_4.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_4.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_4.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_4.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_4.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_24 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
float u_xlat19;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_1.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb5)) ? u_xlat16_1.xyw : u_xlat16_3.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_4.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.w : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_6.xy;
    u_xlat16_6.xy = vec2(u_xlat16_11.x + vs_TEXCOORD0.z, u_xlat16_11.y + vs_TEXCOORD0.w);
    u_xlat16_11.xy = (u_xlatb3.y) ? u_xlat16_6.xy : u_xlat16_11.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_11.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_15.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_15.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_15.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_15.x = u_xlat16_4.x * u_xlat16_15.x + (-u_xlat16_6.x);
    u_xlat16_15.x = u_xlat16_15.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15.x = min(max(u_xlat16_15.x, 0.0), 1.0);
#else
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_15.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_11.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat7.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat7.y;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb7 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb7)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb4.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_24;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat2.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat2.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb4.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_5.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.w) ? u_xlat1.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.z) ? u_xlat1.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_6 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_24 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
mediump vec2 u_xlat16_22;
mediump float u_xlat16_28;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_12.xyz = u_xlat16_4.xxx * u_xlat16_12.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_4.xyz = (bool(u_xlatb8)) ? u_xlat16_5.xyz : u_xlat16_12.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_28 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_28 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_28;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_22.xy = vec2(u_xlat16_6.x + vs_TEXCOORD0.z, u_xlat16_6.y + vs_TEXCOORD0.w);
    u_xlat16_6.xy = (u_xlatb5.y) ? u_xlat16_22.xy : u_xlat16_6.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_6.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb11.y) ? u_xlat1.w : 0.0;
    u_xlat16_6.x = (u_xlatb11.x) ? u_xlat1.z : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.w) ? u_xlat1.y : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.z) ? u_xlat1.x : u_xlat16_6.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_6.x + (-u_xlat16_7);
    u_xlat16_28 = u_xlat16_28 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_28 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_14.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_4.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump float u_xlat16_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat2 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb3 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb3.w) ? u_xlat2.w : 0.0;
    u_xlat16_1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb8)) ? u_xlat16_1.xyw : u_xlat16_4.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb4 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_6 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_6 = (u_xlatb4.w) ? u_xlat2.w : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.z) ? u_xlat2.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.y) ? u_xlat2.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.x) ? u_xlat2.x : u_xlat16_6;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_7.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_7.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_14.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_7.xy;
    u_xlat16_7.xy = vec2(u_xlat16_14.x + vs_TEXCOORD0.z, u_xlat16_14.y + vs_TEXCOORD0.w);
    u_xlat16_14.xy = (u_xlatb5.y) ? u_xlat16_7.xy : u_xlat16_14.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_14.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_17.x = (u_xlatb11.y) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb11.x) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.w) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.z) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7.x = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_17.x = u_xlat16_6 * u_xlat16_17.x + (-u_xlat16_7.x);
    u_xlat16_17.x = u_xlat16_17.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17.x = min(max(u_xlat16_17.x, 0.0), 1.0);
#else
    u_xlat16_17.x = clamp(u_xlat16_17.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_17.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_14.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec2 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
mediump float u_xlat16_23;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb4.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_2.xyz = (u_xlatb4.x) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_23 = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_23 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_23;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb3.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb4.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb4.y) ? u_xlat0.w : 0.0;
    u_xlat16_5.x = (u_xlatb4.x) ? u_xlat0.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_23 = u_xlat16_23 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_23 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_2.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
mediump vec2 u_xlat16_18;
float u_xlat19;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb5)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_24;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_18.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlat16_4.xy = (u_xlatb2.y) ? u_xlat16_18.xy : u_xlat16_4.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_4.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_4.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_4.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_4.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_24 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
float u_xlat19;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_1.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb5)) ? u_xlat16_1.xyw : u_xlat16_3.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_4.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.w : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_6.xy;
    u_xlat16_6.xy = vec2(u_xlat16_11.x + vs_TEXCOORD0.z, u_xlat16_11.y + vs_TEXCOORD0.w);
    u_xlat16_11.xy = (u_xlatb3.y) ? u_xlat16_6.xy : u_xlat16_11.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_11.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_15.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_15.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_15.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_15.x = u_xlat16_4.x * u_xlat16_15.x + (-u_xlat16_6.x);
    u_xlat16_15.x = u_xlat16_15.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15.x = min(max(u_xlat16_15.x, 0.0), 1.0);
#else
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_15.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_11.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat7.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat7.y;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb7 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb7)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb4.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_24;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat2.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat2.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb4.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_5.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.w) ? u_xlat1.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.z) ? u_xlat1.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_6 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_24 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
mediump vec2 u_xlat16_22;
mediump float u_xlat16_28;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_12.xyz = u_xlat16_4.xxx * u_xlat16_12.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_4.xyz = (bool(u_xlatb8)) ? u_xlat16_5.xyz : u_xlat16_12.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_28 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_28 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_28;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_22.xy = vec2(u_xlat16_6.x + vs_TEXCOORD0.z, u_xlat16_6.y + vs_TEXCOORD0.w);
    u_xlat16_6.xy = (u_xlatb5.y) ? u_xlat16_22.xy : u_xlat16_6.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_6.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb11.y) ? u_xlat1.w : 0.0;
    u_xlat16_6.x = (u_xlatb11.x) ? u_xlat1.z : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.w) ? u_xlat1.y : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.z) ? u_xlat1.x : u_xlat16_6.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_6.x + (-u_xlat16_7);
    u_xlat16_28 = u_xlat16_28 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_28 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_14.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_4.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump float u_xlat16_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat2 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb3 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb3.w) ? u_xlat2.w : 0.0;
    u_xlat16_1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb8)) ? u_xlat16_1.xyw : u_xlat16_4.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb4 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_6 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_6 = (u_xlatb4.w) ? u_xlat2.w : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.z) ? u_xlat2.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.y) ? u_xlat2.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.x) ? u_xlat2.x : u_xlat16_6;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_7.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_7.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_14.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_7.xy;
    u_xlat16_7.xy = vec2(u_xlat16_14.x + vs_TEXCOORD0.z, u_xlat16_14.y + vs_TEXCOORD0.w);
    u_xlat16_14.xy = (u_xlatb5.y) ? u_xlat16_7.xy : u_xlat16_14.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_14.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_17.x = (u_xlatb11.y) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb11.x) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.w) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.z) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7.x = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_17.x = u_xlat16_6 * u_xlat16_17.x + (-u_xlat16_7.x);
    u_xlat16_17.x = u_xlat16_17.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17.x = min(max(u_xlat16_17.x, 0.0), 1.0);
#else
    u_xlat16_17.x = clamp(u_xlat16_17.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_17.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_14.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8.x;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb5.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_13.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_13.xy = (u_xlatb1.x) ? u_xlat16_13.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_13.xy);
    u_xlat16_13.x = (u_xlatb5.x) ? u_xlat2.w : 0.0;
    u_xlat16_13.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_13.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_13.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_13.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat16_13.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_8.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_8.x = (u_xlatb5.y) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat16_13 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_13;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_5.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_5.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_9.x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump vec2 u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb6.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_15.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = (u_xlatb1.x) ? u_xlat16_15.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
    u_xlat16_15.x = (u_xlatb6.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_15.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_15.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_9.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15.x = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_9.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_9.x + vs_TEXCOORD0.z, u_xlat16_9.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_9.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_9.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_9.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_9.x = (u_xlatb6.y) ? u_xlat2.w : 0.0;
    u_xlat16_9.x = (u_xlatb6.x) ? u_xlat2.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_9.x;
    u_xlat16_15 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_15;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8.x;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb5.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_8.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_13.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_13.xy = (u_xlatb1.x) ? u_xlat16_13.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_13.xy);
    u_xlat16_13.x = (u_xlatb5.x) ? u_xlat2.w : 0.0;
    u_xlat16_13.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_13.x;
    u_xlat16_13.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_13.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_13.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_13.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat16_13.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x + (-u_xlat16_13.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb5.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_8.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlatb5.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_8.x = (u_xlatb5.y) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat16_13 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_13;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb0.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_5.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_5.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_9.x;
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2 * _DayColor.w;
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump vec2 u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_1.xy = (u_xlatb2.y) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_3.x = (u_xlatb6.y) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.x = (u_xlatb2.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_4.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_15.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = (u_xlatb1.x) ? u_xlat16_15.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
    u_xlat16_15.x = (u_xlatb6.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_15.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_15.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_9.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_9.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15.x = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x + (-u_xlat16_15.x);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
int u_xlati6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat6.x * u_xlat12.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat12.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat12.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat12.y;
    u_xlat16_13.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_13.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb6.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat6.y;
    u_xlat16_9.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_9.x + vs_TEXCOORD0.z, u_xlat16_9.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_9.xy = (u_xlatb1.y) ? u_xlat16_4.xy : u_xlat16_9.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_9.xy);
    u_xlatb6.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_9.x = (u_xlatb6.y) ? u_xlat2.w : 0.0;
    u_xlat16_9.x = (u_xlatb6.x) ? u_xlat2.z : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat16_9.x;
    u_xlat16_15 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat16_3.xw = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xw);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_15;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat16_15 = (-u_xlat2.x) * _MainColor.w + 1.0;
    u_xlat16_4.xyz = vec3(u_xlat2.y * _MainColor.x, u_xlat2.z * _MainColor.y, u_xlat2.w * _MainColor.z);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x + (-u_xlat16_15);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    u_xlatb0 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb0.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb0.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb0.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat16_5.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec2 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
mediump float u_xlat16_23;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb4.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_2.xyz = (u_xlatb4.x) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_23 = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_23 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_23;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb3.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb4.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb4.y) ? u_xlat0.w : 0.0;
    u_xlat16_5.x = (u_xlatb4.x) ? u_xlat0.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_23 = u_xlat16_23 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_23 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_2.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
mediump vec2 u_xlat16_18;
float u_xlat19;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb5)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_24;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_18.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlat16_4.xy = (u_xlatb2.y) ? u_xlat16_18.xy : u_xlat16_4.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_4.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_4.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_4.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_4.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_24 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
float u_xlat19;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_1.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb5)) ? u_xlat16_1.xyw : u_xlat16_3.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_4.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.w : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_6.xy;
    u_xlat16_6.xy = vec2(u_xlat16_11.x + vs_TEXCOORD0.z, u_xlat16_11.y + vs_TEXCOORD0.w);
    u_xlat16_11.xy = (u_xlatb3.y) ? u_xlat16_6.xy : u_xlat16_11.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_11.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_15.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_15.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_15.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_15.x = u_xlat16_4.x * u_xlat16_15.x + (-u_xlat16_6.x);
    u_xlat16_15.x = u_xlat16_15.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15.x = min(max(u_xlat16_15.x, 0.0), 1.0);
#else
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_15.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_11.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat7.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat7.y;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb7 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb7)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb4.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_24;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat2.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat2.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb4.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_5.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.w) ? u_xlat1.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.z) ? u_xlat1.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_6 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_24 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
mediump vec2 u_xlat16_22;
mediump float u_xlat16_28;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_12.xyz = u_xlat16_4.xxx * u_xlat16_12.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_4.xyz = (bool(u_xlatb8)) ? u_xlat16_5.xyz : u_xlat16_12.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_28 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_28 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_28;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_22.xy = vec2(u_xlat16_6.x + vs_TEXCOORD0.z, u_xlat16_6.y + vs_TEXCOORD0.w);
    u_xlat16_6.xy = (u_xlatb5.y) ? u_xlat16_22.xy : u_xlat16_6.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_6.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb11.y) ? u_xlat1.w : 0.0;
    u_xlat16_6.x = (u_xlatb11.x) ? u_xlat1.z : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.w) ? u_xlat1.y : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.z) ? u_xlat1.x : u_xlat16_6.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_6.x + (-u_xlat16_7);
    u_xlat16_28 = u_xlat16_28 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_28 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_14.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_4.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump float u_xlat16_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat2 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb3 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb3.w) ? u_xlat2.w : 0.0;
    u_xlat16_1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb8)) ? u_xlat16_1.xyw : u_xlat16_4.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb4 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_6 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_6 = (u_xlatb4.w) ? u_xlat2.w : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.z) ? u_xlat2.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.y) ? u_xlat2.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.x) ? u_xlat2.x : u_xlat16_6;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_7.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_7.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_14.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_7.xy;
    u_xlat16_7.xy = vec2(u_xlat16_14.x + vs_TEXCOORD0.z, u_xlat16_14.y + vs_TEXCOORD0.w);
    u_xlat16_14.xy = (u_xlatb5.y) ? u_xlat16_7.xy : u_xlat16_14.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_14.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_17.x = (u_xlatb11.y) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb11.x) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.w) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.z) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7.x = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_17.x = u_xlat16_6 * u_xlat16_17.x + (-u_xlat16_7.x);
    u_xlat16_17.x = u_xlat16_17.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17.x = min(max(u_xlat16_17.x, 0.0), 1.0);
#else
    u_xlat16_17.x = clamp(u_xlat16_17.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_17.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_14.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec2 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
mediump float u_xlat16_23;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + _LerpColorDark.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb4.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_2.xyz = (u_xlatb4.x) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_23 = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_23 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_23;
    u_xlat16_23 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_23;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb3.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb4.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb4.y) ? u_xlat0.w : 0.0;
    u_xlat16_5.x = (u_xlatb4.x) ? u_xlat0.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_23 = u_xlat16_23 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_23 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_2.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
mediump vec2 u_xlat16_18;
float u_xlat19;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb5)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_24;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_18.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlat16_4.xy = (u_xlatb2.y) ? u_xlat16_18.xy : u_xlat16_4.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_4.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_4.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_4.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_4.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_24 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
mediump vec3 u_xlat16_11;
float u_xlat12;
bvec2 u_xlatb12;
mediump vec2 u_xlat16_15;
float u_xlat19;
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
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_15.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_15.xy = (u_xlatb0.x) ? u_xlat16_15.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_15.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_15.x = (u_xlatb0.x) ? u_xlat2.w : 0.0;
    u_xlat16_15.x = (u_xlatb0.w) ? u_xlat2.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.z) ? u_xlat2.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb0.y) ? u_xlat2.x : u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_1.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb5 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb5)) ? u_xlat16_1.xyw : u_xlat16_3.xyz;
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat12) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat19 + u_xlat12;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_4.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat0.w : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_4.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_11.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_15.xx + u_xlat16_6.xy;
    u_xlat16_6.xy = vec2(u_xlat16_11.x + vs_TEXCOORD0.z, u_xlat16_11.y + vs_TEXCOORD0.w);
    u_xlat16_11.xy = (u_xlatb3.y) ? u_xlat16_6.xy : u_xlat16_11.xy;
    u_xlat0 = texture(_DissolveTex, u_xlat16_11.xy);
    u_xlatb12.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_15.x = (u_xlatb12.y) ? u_xlat0.w : 0.0;
    u_xlat16_15.x = (u_xlatb12.x) ? u_xlat0.z : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.w) ? u_xlat0.y : u_xlat16_15.x;
    u_xlat16_15.x = (u_xlatb3.z) ? u_xlat0.x : u_xlat16_15.x;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat16_6.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_15.x = u_xlat16_4.x * u_xlat16_15.x + (-u_xlat16_6.x);
    u_xlat16_15.x = u_xlat16_15.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15.x = min(max(u_xlat16_15.x, 0.0), 1.0);
#else
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_15.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_11.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_12;
mediump vec2 u_xlat16_19;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat7.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat7.y;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _LerpColorDark.xyz;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb7 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb7)) ? u_xlat16_4.xyz : u_xlat16_10.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_24 = (u_xlatb4.x) ? 1.0 : 0.0;
    u_xlat16_24 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_24;
    u_xlat16_24 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_24;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_5.x = _Time.y * _DissolveTex_Uspeed + u_xlat2.x;
    u_xlat16_5.y = _Time.y * _DissolveTex_Vspeed + u_xlat2.y;
    u_xlat16_19.xy = vec2(u_xlat16_5.x + vs_TEXCOORD0.z, u_xlat16_5.y + vs_TEXCOORD0.w);
    u_xlat16_5.xy = (u_xlatb4.y) ? u_xlat16_19.xy : u_xlat16_5.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_5.xy);
    u_xlatb2.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_5.x = (u_xlatb2.y) ? u_xlat1.w : 0.0;
    u_xlat16_5.x = (u_xlatb2.x) ? u_xlat1.z : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.w) ? u_xlat1.y : u_xlat16_5.x;
    u_xlat16_5.x = (u_xlatb4.z) ? u_xlat1.x : u_xlat16_5.x;
    u_xlat16_12.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_6 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_5.x + (-u_xlat16_6);
    u_xlat16_24 = u_xlat16_24 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_24 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat16_0 * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
mediump vec2 u_xlat16_22;
mediump float u_xlat16_28;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_4.x = (u_xlatb2.w) ? u_xlat1.w : 0.0;
    u_xlat16_4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_12.xyz = u_xlat16_4.xxx * u_xlat16_12.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_4.xyz = (bool(u_xlatb8)) ? u_xlat16_5.xyz : u_xlat16_12.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_28 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_28 = (u_xlatb2.w) ? u_xlat1.w : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_28;
    u_xlat16_28 = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_28;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_6.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_6.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_22.xy = vec2(u_xlat16_6.x + vs_TEXCOORD0.z, u_xlat16_6.y + vs_TEXCOORD0.w);
    u_xlat16_6.xy = (u_xlatb5.y) ? u_xlat16_22.xy : u_xlat16_6.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_6.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb11.y) ? u_xlat1.w : 0.0;
    u_xlat16_6.x = (u_xlatb11.x) ? u_xlat1.z : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.w) ? u_xlat1.y : u_xlat16_6.x;
    u_xlat16_6.x = (u_xlatb5.z) ? u_xlat1.x : u_xlat16_6.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_6.x + (-u_xlat16_7);
    u_xlat16_28 = u_xlat16_28 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_28 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_14.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_4.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat9 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump vec4 _LerpColorDark;
uniform 	mediump vec4 _LerpColorLight;
uniform 	mediump float _LerpAlphaScaler;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoParticlesDissolve_4Texs_VertexAniArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesDissolve_4Texs_VertexAni {
	miHoYoParticlesDissolve_4Texs_VertexAniArray_Type miHoYoParticlesDissolve_4Texs_VertexAniArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump vec3 u_xlat16_4;
bvec4 u_xlatb4;
mediump vec3 u_xlat16_5;
bvec4 u_xlatb5;
mediump float u_xlat16_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat11;
bvec2 u_xlatb11;
mediump vec3 u_xlat16_14;
mediump vec2 u_xlat16_17;
float u_xlat19;
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
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat16_1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat16_2.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlatb3 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_17.xy = vec2(u_xlat16_2.x + vs_TEXCOORD0.z, u_xlat16_2.y + vs_TEXCOORD0.w);
    u_xlat16_17.xy = (u_xlatb3.x) ? u_xlat16_17.xy : u_xlat16_2.xy;
    u_xlat2 = texture(_NoiseTex, u_xlat16_17.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb8 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat16_17.x = (u_xlatb8) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_17.x = u_xlat16_17.x + (-_Noise_Offset);
    u_xlat16_1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_1.xy;
    u_xlat2 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlatb3 = equal(vec4(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_1.x = (u_xlatb3.w) ? u_xlat2.w : 0.0;
    u_xlat16_1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat16_1.x;
    u_xlat16_1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _LerpAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _LerpColorDark.xyz;
    u_xlat16_5.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xxx * u_xlat16_5.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb8 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat16_1.xyw = (bool(u_xlatb8)) ? u_xlat16_1.xyw : u_xlat16_4.xyz;
    u_xlat0 = vs_COLOR0.wxyz * miHoYoParticlesDissolve_4Texs_VertexAniArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat11.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat19 + u_xlat11.x;
    u_xlatb4 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_BaseTexAlphaChannelSwitch, _DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(4.0, 1.0, 0.0, 1.0));
    u_xlat16_6 = (u_xlatb5.x) ? 1.0 : 0.0;
    u_xlat16_6 = (u_xlatb4.w) ? u_xlat2.w : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.z) ? u_xlat2.z : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.y) ? u_xlat2.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb4.x) ? u_xlat2.x : u_xlat16_6;
    u_xlat11.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_7.x = _Time.y * _DissolveTex_Uspeed + u_xlat11.x;
    u_xlat16_7.y = _Time.y * _DissolveTex_Vspeed + u_xlat11.y;
    u_xlat16_14.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_17.xx + u_xlat16_7.xy;
    u_xlat16_7.xy = vec2(u_xlat16_14.x + vs_TEXCOORD0.z, u_xlat16_14.y + vs_TEXCOORD0.w);
    u_xlat16_14.xy = (u_xlatb5.y) ? u_xlat16_7.xy : u_xlat16_14.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_14.xy);
    u_xlatb11.xy = equal(vec4(vec4(_DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch)), vec4(2.0, 3.0, 0.0, 0.0)).xy;
    u_xlat16_17.x = (u_xlatb11.y) ? u_xlat2.w : 0.0;
    u_xlat16_17.x = (u_xlatb11.x) ? u_xlat2.z : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.w) ? u_xlat2.y : u_xlat16_17.x;
    u_xlat16_17.x = (u_xlatb5.z) ? u_xlat2.x : u_xlat16_17.x;
    u_xlat16_14.xyz = vec3(u_xlat0.y * _MainColor.x, u_xlat0.z * _MainColor.y, u_xlat0.w * _MainColor.z);
    u_xlat16_7.x = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_17.x = u_xlat16_6 * u_xlat16_17.x + (-u_xlat16_7.x);
    u_xlat16_17.x = u_xlat16_17.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17.x = min(max(u_xlat16_17.x, 0.0), 1.0);
#else
    u_xlat16_17.x = clamp(u_xlat16_17.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_17.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_14.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0.xyz = u_xlat16_1.xyz * _DayColor.xyz;
    SV_Target0.w = u_xlat0.x * _DayColor.w;
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
Keywords { "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 109006
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_VertexAniNoiseUVPannerXY.x, _VertexAniNoiseUVPannerXY.y) + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	mediump float _DistortionTexRG_Uspeed;
uniform 	vec4 _DistortionTexRG_ST;
uniform 	mediump float _DistortionTexRG_Vspeed;
uniform 	mediump float _DistortionRScaler;
uniform 	mediump float _DistortionGScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DistortionMaskChannelToggle;
uniform 	vec4 _DistortionMaskTex_ST;
uniform 	mediump float _DistortionOpacity;
uniform lowp sampler2D _DistortionTexRG;
uniform lowp sampler2D _DistortionMaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortionMaskTex_ST.xy + _DistortionMaskTex_ST.zw;
    u_xlat0 = texture(_DistortionMaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DistortionMaskChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5;
    SV_Target0.w = u_xlat16_2.x * _DistortionOpacity;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortionTexRG_ST.xy + _DistortionTexRG_ST.zw;
    u_xlat16_2.x = _Time.y * _DistortionTexRG_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _DistortionTexRG_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_DistortionTexRG, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.xy = vec2(u_xlat16_2.x * float(_DistortionRScaler), u_xlat16_2.y * float(_DistortionGScaler));
    u_xlat16_2.z = (-u_xlat16_2.x);
    SV_Target0.xy = vec2(u_xlat16_2.z + float(0.497999996), u_xlat16_2.y + float(0.497999996));
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xy = min(max(SV_Target0.xy, 0.0), 1.0);
#else
    SV_Target0.xy = clamp(SV_Target0.xy, 0.0, 1.0);
#endif
    SV_Target0.z = 0.0;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_VertexAniNoiseUVPannerXY.x, _VertexAniNoiseUVPannerXY.y) + u_xlat0.xy;
    u_xlat0.xyz = textureLod(_VertexAniNoiseTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat6 = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _DistortionTexRG_Uspeed;
uniform 	vec4 _DistortionTexRG_ST;
uniform 	mediump float _DistortionTexRG_Vspeed;
uniform 	mediump float _DistortionRScaler;
uniform 	mediump float _DistortionGScaler;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DistortionMaskChannelToggle;
uniform 	vec4 _DistortionMaskTex_ST;
uniform 	mediump float _DistortionOpacity;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTexRG;
uniform lowp sampler2D _DistortionMaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
int u_xlati0;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortionMaskTex_ST.xy + _DistortionMaskTex_ST.zw;
    u_xlat0 = texture(_DistortionMaskTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_DistortionMaskChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2.x = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_5 = u_xlat0.x * _MainColor.w;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5;
    SV_Target0.w = u_xlat16_2.x * _DistortionOpacity;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortionTexRG_ST.xy + _DistortionTexRG_ST.zw;
    u_xlat16_2.x = _Time.y * _DistortionTexRG_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _DistortionTexRG_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_DistortionTexRG, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.xy = vec2(u_xlat16_2.x * float(_DistortionRScaler), u_xlat16_2.y * float(_DistortionGScaler));
    u_xlat16_2.z = (-u_xlat16_2.x);
    SV_Target0.xy = vec2(u_xlat16_2.z + float(0.497999996), u_xlat16_2.y + float(0.497999996));
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xy = min(max(SV_Target0.xy, 0.0), 1.0);
#else
    SV_Target0.xy = clamp(SV_Target0.xy, 0.0, 1.0);
#endif
    SV_Target0.z = 0.0;
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
  GpuProgramID 176593
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
vec3 u_xlat3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat3.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat3.xy;
    u_xlat3.xyz = textureLod(_VertexAniNoiseTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat3.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_3 = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_8 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3 = u_xlat16_8 * u_xlat16_3 + (-u_xlat16_13);
    u_xlat16_3 = u_xlat16_3 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat16_0 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
vec3 u_xlat3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat3.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat3.xy;
    u_xlat3.xyz = textureLod(_VertexAniNoiseTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat3.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb1.x) ? u_xlat16_8.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlat16_8.x = (u_xlatb0) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
vec3 u_xlat3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat3.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat3.xy;
    u_xlat3.xyz = textureLod(_VertexAniNoiseTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat3.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb0.x) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_8.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat16_8.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_8.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat4.xyz = textureLod(_VertexAniNoiseTex, u_xlat4.xy, 0.0).xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat4.xyz = u_xlat4.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_3 = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_8 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_13 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_3 = u_xlat16_8 * u_xlat16_3 + (-u_xlat16_13);
    u_xlat16_3 = u_xlat16_3 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat16_0 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat4.xyz = textureLod(_VertexAniNoiseTex, u_xlat4.xy, 0.0).xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat4.xyz = u_xlat4.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb1.x) ? u_xlat16_8.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlat16_8.x = (u_xlatb0) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_8.x;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_13 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat4.xyz = textureLod(_VertexAniNoiseTex, u_xlat4.xy, 0.0).xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat4.xyz = u_xlat4.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb0.x) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_8.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat16_8.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_8.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_13 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
vec3 u_xlat3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat3.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat3.xy;
    u_xlat3.xyz = textureLod(_VertexAniNoiseTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat3.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_3 = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_8 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3 = u_xlat16_8 * u_xlat16_3 + (-u_xlat16_13);
    u_xlat16_3 = u_xlat16_3 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat16_0 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
vec3 u_xlat3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat3.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat3.xy;
    u_xlat3.xyz = textureLod(_VertexAniNoiseTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat3.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb1.x) ? u_xlat16_8.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlat16_8.x = (u_xlatb0) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_8.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
vec3 u_xlat3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat3.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat3.xy;
    u_xlat3.xyz = textureLod(_VertexAniNoiseTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat3.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
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
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb0.x) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_8.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat16_8.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_8.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_13 = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat4.xyz = textureLod(_VertexAniNoiseTex, u_xlat4.xy, 0.0).xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat4.xyz = u_xlat4.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_1.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_3 = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3 = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3;
    u_xlat16_3 = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_8 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_BaseTex, u_xlat16_4.xy);
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_8 = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_8;
    u_xlat16_8 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_8;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_13 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_3 = u_xlat16_8 * u_xlat16_3 + (-u_xlat16_13);
    u_xlat16_3 = u_xlat16_3 * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat16_0 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat4.xyz = textureLod(_VertexAniNoiseTex, u_xlat4.xy, 0.0).xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat4.xyz = u_xlat4.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0 = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat5.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat5.y;
    u_xlat16_8.xy = vec2(u_xlat16_4.x + vs_TEXCOORD0.z, u_xlat16_4.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb1.x) ? u_xlat16_8.xy : u_xlat16_4.xy;
    u_xlat2 = texture(_DissolveTex, u_xlat16_8.xy);
    u_xlat16_8.x = (u_xlatb0) ? u_xlat2.w : 0.0;
    u_xlat16_8.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat16_8.x;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_13 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump vec2 _VertexAniNoiseUVPannerXY;
uniform 	vec4 _VertexAniNoiseTex_ST;
uniform 	mediump float _VertexAniNoiseTexSubtract;
uniform 	mediump float _VertexAniNosieChannelNum;
uniform 	vec4 _VertexAniNoiseMaskTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _VertexAniNoiseTex;
uniform lowp sampler2D _VertexAniNoiseMaskTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _VertexAniNoiseTex_ST.xy + _VertexAniNoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _VertexAniNoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat4.xyz = textureLod(_VertexAniNoiseTex, u_xlat4.xy, 0.0).xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(_VertexAniNoiseTexSubtract));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_VertexAniNosieChannelNum, _VertexAniNosieChannelNum, _VertexAniNosieChannelNum));
    u_xlat1.xy = in_TEXCOORD0.xy * _VertexAniNoiseMaskTex_ST.xy + _VertexAniNoiseMaskTex_ST.zw;
    u_xlat1.x = textureLod(_VertexAniNoiseMaskTex, u_xlat1.xy, 0.0).x;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat4.xyz = u_xlat4.xyz * in_NORMAL0.xyz + in_POSITION0.xyz;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump vec4 _DayColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTex_Vspeed;
uniform 	mediump float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	mediump float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseTex_Vspeed;
uniform 	mediump float _Noise_Offset;
uniform 	mediump float _DissolveTexChannelSwitch;
uniform 	mediump float _DissolveTexUVRandomToggle;
uniform 	mediump float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveTex_Vspeed;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaEdgeFade;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
bvec4 u_xlatb1;
ivec2 u_xlati2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_8;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat16_1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat16_11.xy = vec2(u_xlat16_1.x + vs_TEXCOORD0.z, u_xlat16_1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.xy = (u_xlatb2.x) ? u_xlat16_11.xy : u_xlat16_1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat16_1.xy);
    u_xlat16_3.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_3.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x + (-_Noise_Offset);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat16_4.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat16_8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat16_4.xy = vec2(u_xlat16_8.x + vs_TEXCOORD0.z, u_xlat16_8.y + vs_TEXCOORD0.w);
    u_xlatb0 = equal(vec4(_DissolveTexUVRandomToggle, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch, _DissolveTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_8.xy = (u_xlatb0.x) ? u_xlat16_4.xy : u_xlat16_8.xy;
    u_xlat1 = texture(_DissolveTex, u_xlat16_8.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_DissolveTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _DissolveTexChannelSwitch==3.0;
#endif
    u_xlat16_8.x = (u_xlatb0.x) ? u_xlat1.w : 0.0;
    u_xlat16_8.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat16_8.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat16_4.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat16_4.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat16_3.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat16_3.xx + u_xlat16_4.xy;
    u_xlat0 = texture(_BaseTex, u_xlat16_3.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat16_3.x = (u_xlatb2.x) ? 1.0 : 0.0;
    u_xlatb1 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_3.x = (u_xlatb1.w) ? u_xlat0.w : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_13 = (-u_xlat0.x) * _MainColor.w + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x + (-u_xlat16_13);
    u_xlat16_3.x = u_xlat16_3.x * _AlphaEdgeFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati2.xy;
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
Keywords { "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_SOFTPARTICLES_ON" "_NOISETEXTOGGLEONBASETEX_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}