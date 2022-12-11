//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Dissolve_VertexAni" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _BaseTexColorChannelToggle ("BaseTexColorChannelToggle", Float) = 1
[Enum(A,0,R,1,G,2,B,3)] _BaseTexAlphaChannelToggle ("BaseTexAlphaChannelToggle", Float) = 1
_BaseTex_Uspeed ("BaseTex_Uspeed", Float) = 1
_BaseTex_Vspeed ("BaseTex_Vspeed", Float) = 1
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NosieChannelNum ("NosieChannelNum", Range(0, 4)) = 1
_NoiseUVPannerXY ("NoiseUVPanner(XY)", Vector) = (0,0,0,0)
_VertexAniRangeXY ("VertexAniRange(XY)", Vector) = (0,0,0,0)
_DistortTex ("DistortTex", Range(0, 1)) = 0
_DissolveTex ("DissolveTex", 2D) = "white" { }
_DissolveChannelNum ("DissolveChannelNum", Range(0, 4)) = 1
_DissolveTexPannerXY ("DissolveTexPanner(XY)", Vector) = (0,0,0,0)
_DissolveScale ("DissolveScale", Float) = 1
_DissolveAni ("DissolveAni", Range(0, 1)) = 0
_DissovleOutLineColor ("DissovleOutLineColor", Color) = (1,1,1,0)
_DissovleOutColorScale ("DissovleOutColorScale", Float) = 1
_AlphaScale ("AlphaScale", Float) = 1
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
  GpuProgramID 59221
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat1.w = u_xlat0.x * _AlphaScale;
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_DissolveAni) + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) * u_xlat16_2.x + 1.0;
    u_xlat16_7 = -1.0 / _DissolveScale;
    u_xlat16_12 = (-u_xlat16_7) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12 + u_xlat16_7;
    u_xlat16_2.y = u_xlat16_5.x + (-u_xlat16_2.x);
    u_xlat16_12 = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_12 = log2(u_xlat16_12);
    u_xlat16_17 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_12 = min(u_xlat16_12, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_12;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_2.y) + u_xlat16_2.x;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat0.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb3.x = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat3.x = u_xlatb3.x ? u_xlat0.w : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = (u_xlatb1.w) ? u_xlat0.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xyz = (u_xlatb1.x) ? u_xlat0.xyz : u_xlat3.xxx;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_7) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10 * u_xlat15 + u_xlat5.x;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7 = _DayColor.w * _AlphaBrightness;
    u_xlat7 = u_xlat16_3.y * u_xlat7;
    u_xlat7 = u_xlat7 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat0.w = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    return;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissovleOutColorScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
mediump float u_xlat16_15;
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
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
    u_xlat6.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat6.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_BaseTexColorChannelToggle==4.0);
#else
    u_xlatb6 = _BaseTexColorChannelToggle==4.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat4.xy;
    u_xlat16_3.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat4.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat16_3.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_5 + u_xlat16_0.x;
    u_xlat16_3.x = (-_DissolveAni) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_3.x = (-vs_COLOR0.w) * u_xlat16_3.x + 1.0;
    u_xlat16_15 = (-u_xlat16_9) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_15 + u_xlat16_9;
    u_xlat16_9 = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_15 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = min(u_xlat16_9, 1.0);
    u_xlat16_3.y = (-u_xlat16_3.x) + u_xlat16_9;
    u_xlat6.xyz = u_xlat6.xyz * vec3(_ColorBrightness);
    u_xlat6.xyz = u_xlat6.xyz * vs_COLOR0.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _MainColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * _DayColor.xyz;
    u_xlat16_3.x = u_xlat16_0.x + (-u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat4.xyz = _DissovleOutLineColor.xyz * vec3(_DissovleOutColorScale) + (-u_xlat6.xyz);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat7.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat13 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat13) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat19 + u_xlat13;
    u_xlat13 = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat16_3.y * u_xlat13;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat1.x = u_xlat1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat7.x * u_xlat1.x;
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
  GpuProgramID 93909
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.xxyx.y;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.xxyx.y;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
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
  GpuProgramID 183316
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat2.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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
Keywords { "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat2.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
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
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat16_4 = u_xlat0.x * u_xlat5.x + (-_MotionVectorsAlphaCutoff);
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat1 = textureLod(_NoiseTex, u_xlat4.xy, 0.0);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = u_xlat1.xy * u_xlat16_2.xy;
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat4.x = u_xlat1.z * u_xlat16_2.z + u_xlat4.x;
    u_xlat4.x = u_xlat1.w * u_xlat16_2.w + u_xlat4.x;
    u_xlat16_2.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat4.x = u_xlat4.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_2.x = u_xlat4.x * u_xlat16_2.x + _VertexAniRangeXY.x;
    u_xlat4.xyz = in_NORMAL0.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
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

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat1 = textureLod(_NoiseTex, u_xlat4.xy, 0.0);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = u_xlat1.xy * u_xlat16_2.xy;
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat4.x = u_xlat1.z * u_xlat16_2.z + u_xlat4.x;
    u_xlat4.x = u_xlat1.w * u_xlat16_2.w + u_xlat4.x;
    u_xlat16_2.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat4.x = u_xlat4.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_2.x = u_xlat4.x * u_xlat16_2.x + _VertexAniRangeXY.x;
    u_xlat4.xyz = in_NORMAL0.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
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

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat16_4 = u_xlat0.x * u_xlat5.x + (-_MotionVectorsAlphaCutoff);
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat2.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat0 = textureLod(_NoiseTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.x;
    u_xlat0.xyz = in_NORMAL0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat2.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
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
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat16_4 = u_xlat0.x * u_xlat5.x + (-_MotionVectorsAlphaCutoff);
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat1 = textureLod(_NoiseTex, u_xlat4.xy, 0.0);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = u_xlat1.xy * u_xlat16_2.xy;
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat4.x = u_xlat1.z * u_xlat16_2.z + u_xlat4.x;
    u_xlat4.x = u_xlat1.w * u_xlat16_2.w + u_xlat4.x;
    u_xlat16_2.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat4.x = u_xlat4.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_2.x = u_xlat4.x * u_xlat16_2.x + _VertexAniRangeXY.x;
    u_xlat4.xyz = in_NORMAL0.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
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

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
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
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat4.xy;
    u_xlat1 = textureLod(_NoiseTex, u_xlat4.xy, 0.0);
    u_xlat16_2 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = u_xlat1.xy * u_xlat16_2.xy;
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat4.x = u_xlat1.z * u_xlat16_2.z + u_xlat4.x;
    u_xlat4.x = u_xlat1.w * u_xlat16_2.w + u_xlat4.x;
    u_xlat16_2.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat4.x = u_xlat4.x + u_xlat16_2.x;
    u_xlat16_2.x = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_2.x = u_xlat4.x * u_xlat16_2.x + _VertexAniRangeXY.x;
    u_xlat4.xyz = in_NORMAL0.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
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

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _NoiseUVPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NosieChannelNum;
uniform 	mediump float _DistortTex;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump vec4 _DissovleOutLineColor;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveAni;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
ivec2 u_xlati3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat10;
ivec2 u_xlati10;
mediump float u_xlat16_12;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NosieChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_NosieChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat5.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat5.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_5.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = (-_DissovleOutLineColor.w) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_7 = (-_DissolveAni) + 1.0;
    u_xlat16_7 = (-vs_COLOR0.w) * u_xlat16_7 + 1.0;
    u_xlat16_12 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_12) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_17 + u_xlat16_12;
    u_xlat16_2.x = (-u_xlat16_7) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat16_2.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = u_xlat16_0.xx * vec2(vec2(_DistortTex, _DistortTex)) + u_xlat3.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat16_4 = u_xlat0.x * u_xlat5.x + (-_MotionVectorsAlphaCutoff);
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
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
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