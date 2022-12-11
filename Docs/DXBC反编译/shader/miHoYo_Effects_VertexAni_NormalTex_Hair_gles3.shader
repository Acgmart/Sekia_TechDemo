//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/VertexAni_NormalTex_Hair" {
Properties {
_NormalTex ("NormalTex", 2D) = "white" { }
_NormalTexPannerXY ("NormalTexPanner(XY)", Vector) = (0,0,0,0)
_VertexAniRangeXY ("VertexAniRange(XY)", Vector) = (0,0,0,0)
_VertexAniOffsetThreshold ("VertexAniOffsetThreshold", Float) = 0
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorScale ("MainColorScale", Float) = 1
_DissolveTex ("DissolveTex", 2D) = "white" { }
_DissolveChannelNum ("DissolveChannelNum", Range(0, 4)) = 1
_DissolveScale ("DissolveScale", Float) = 1
_DissolveEndColor ("DissolveEndColor", Color) = (1,1,1,1)
_DissolveTexPannerXY ("DissolveTexPanner(XY)", Vector) = (0,0,0,0)
_DissolveOffset ("DissolveOffset", Float) = 0
_Shape_Texture ("Shape_Texture", 2D) = "white" { }
_ShapeTexChannelNum ("ShapeTexChannelNum", Range(0, 4)) = 1
_AlphaScale ("AlphaScale", Float) = 1
_LineRange ("LineRange", Range(0, 0.99)) = 0.99
_LinePower ("LinePower", Float) = 1
_LineColor ("LineColor", Color) = (1,1,1,1)
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
  GpuProgramID 15541
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
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
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_6 = -1.0 / _DissolveScale;
    u_xlat16_10 = (-u_xlat16_6) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10 + u_xlat16_6;
    u_xlat16_2.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_3 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_2.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
int u_xlati21;
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
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
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat14 = u_xlat0.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<abs(u_xlat0.x));
#else
    u_xlatb0 = 0.00999999978<abs(u_xlat0.x);
#endif
    u_xlat16_3.x = (u_xlatb0) ? u_xlat14 : 1.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat14 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat14 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_10 = (u_xlatb14) ? u_xlat23 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat14 = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat14) + 2.0;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat14 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat14 = u_xlat14 + 1.0;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat14) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat0.x = u_xlat0.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat0.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat14) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_6 = -1.0 / _DissolveScale;
    u_xlat16_10 = (-u_xlat16_6) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10 + u_xlat16_6;
    u_xlat16_2.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_3 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_2.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
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
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_6 = -1.0 / _DissolveScale;
    u_xlat16_10 = (-u_xlat16_6) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10 + u_xlat16_6;
    u_xlat16_2.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_3 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_2.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_5.x = -1.0 / _DissolveScale;
    u_xlat16_9 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9 + u_xlat16_5.x;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_4.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
int u_xlati21;
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
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
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat14 = u_xlat0.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<abs(u_xlat0.x));
#else
    u_xlatb0 = 0.00999999978<abs(u_xlat0.x);
#endif
    u_xlat16_3.x = (u_xlatb0) ? u_xlat14 : 1.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat14 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat14 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_10 = (u_xlatb14) ? u_xlat23 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat14 = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat14) + 2.0;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat14 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat14 = u_xlat14 + 1.0;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat14) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat0.x = u_xlat0.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat0.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat14) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat4.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat4.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_9 = _LineRange + -0.00999999978;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_13 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _LinePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_5.x = u_xlat16_9 * u_xlat16_5.x + (-u_xlat16_13);
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_6 = -1.0 / _DissolveScale;
    u_xlat16_10 = (-u_xlat16_6) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10 + u_xlat16_6;
    u_xlat16_2.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_3 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_2.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
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
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_6.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_11 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * _LinePower;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_1.x = u_xlat16_6.x * u_xlat16_1.x + (-u_xlat16_11);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat16_16 = -1.0 / _DissolveScale;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_7 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = u_xlat16_2.x * u_xlat16_7 + u_xlat16_16;
    u_xlat5.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat5.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_16 = u_xlat0.x + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * u_xlat16_16;
    u_xlat16_5.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_4 + u_xlat16_5.x;
    u_xlat0.x = u_xlat16_5.x * u_xlat0.x;
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
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
int u_xlati21;
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
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
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat14 = u_xlat0.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<abs(u_xlat0.x));
#else
    u_xlatb0 = 0.00999999978<abs(u_xlat0.x);
#endif
    u_xlat16_3.x = (u_xlatb0) ? u_xlat14 : 1.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat14 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat14 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_10 = (u_xlatb14) ? u_xlat23 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat14 = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat14) + 2.0;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat14 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat14 = u_xlat14 + 1.0;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat14) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat0.x = u_xlat0.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat0.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat14) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_6.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_11 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * _LinePower;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_1.x = u_xlat16_6.x * u_xlat16_1.x + (-u_xlat16_11);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat16_16 = -1.0 / _DissolveScale;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_7 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = u_xlat16_2.x * u_xlat16_7 + u_xlat16_16;
    u_xlat5.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat5.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_16 = u_xlat0.x + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * u_xlat16_16;
    u_xlat16_5.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_4 + u_xlat16_5.x;
    u_xlat0.x = u_xlat16_5.x * u_xlat0.x;
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
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
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
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_6.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_11 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * _LinePower;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_1.x = u_xlat16_6.x * u_xlat16_1.x + (-u_xlat16_11);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat16_16 = -1.0 / _DissolveScale;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_7 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = u_xlat16_2.x * u_xlat16_7 + u_xlat16_16;
    u_xlat5.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat5.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_16 = u_xlat0.x + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * u_xlat16_16;
    u_xlat16_5.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_4 + u_xlat16_5.x;
    u_xlat0.x = u_xlat16_5.x * u_xlat0.x;
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
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_5.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_9 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_9 = log2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * _LinePower;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x + (-u_xlat16_9);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = -1.0 / _DissolveScale;
    u_xlat16_5.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_9 + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat4.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_4.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_5.x + u_xlat16_4.x;
    u_xlat0.x = u_xlat16_4.x * u_xlat0.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
int u_xlati21;
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat7 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat7 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_22 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
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
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat14 = u_xlat0.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<abs(u_xlat0.x));
#else
    u_xlatb0 = 0.00999999978<abs(u_xlat0.x);
#endif
    u_xlat16_3.x = (u_xlatb0) ? u_xlat14 : 1.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat14 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat14 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_10 = (u_xlatb14) ? u_xlat23 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat14 = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat14) + 2.0;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat14 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat14 = u_xlat14 + 1.0;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat14) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat0.x = u_xlat0.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat0.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat14) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	mediump vec4 _LineColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump float _LineRange;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LinePower;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _DissolveScale;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = _LineRange + -0.00999999978;
    u_xlat16_6.x = u_xlat0.x + -0.00999999978;
    u_xlat16_1.x = float(1.0) / u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_11 = max(vs_TEXCOORD0.y, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * _LinePower;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_1.x = u_xlat16_6.x * u_xlat16_1.x + (-u_xlat16_11);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale) + (-_LineColor.xyz);
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz + _LineColor.xyz;
    u_xlat16_2.xyz = (-_LineColor.xyz) + _DissolveEndColor.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + _LineColor.xyz;
    u_xlat16_1.x = u_xlat3 + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat16_16 = -1.0 / _DissolveScale;
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_7 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = u_xlat16_2.x * u_xlat16_7 + u_xlat16_16;
    u_xlat5.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat5.xy);
    u_xlat16_3 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_16 = u_xlat0.x + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat5.x * u_xlat16_16;
    u_xlat16_5.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_4 + u_xlat16_5.x;
    u_xlat0.x = u_xlat16_5.x * u_xlat0.x;
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
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
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
  GpuProgramID 123428
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat2 = (-_VertexAniRangeXY.xxxy.z) + _VertexAniRangeXY.xxxy.w;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _VertexAniRangeXY.xxxy.z;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_7 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
float u_xlat2;
int u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat2 = (-_VertexAniRangeXY.xxxy.z) + _VertexAniRangeXY.xxxy.w;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _VertexAniRangeXY.xxxy.z;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_7 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
  GpuProgramID 164995
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat3.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat3.xy;
    u_xlat3.x = textureLod(_NormalTex, u_xlat3.xy, 0.0).x;
    u_xlat6 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat3.x = u_xlat3.x * u_xlat6 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat3.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat3.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat3.xy;
    u_xlat3.x = textureLod(_NormalTex, u_xlat3.xy, 0.0).x;
    u_xlat6 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat3.x = u_xlat3.x * u_xlat6 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat3.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat4.xy;
    u_xlat4.x = textureLod(_NormalTex, u_xlat4.xy, 0.0).x;
    u_xlat8 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat4.x = u_xlat4.x * u_xlat8 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat4.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat4.xy;
    u_xlat4.x = textureLod(_NormalTex, u_xlat4.xy, 0.0).x;
    u_xlat8 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat4.x = u_xlat4.x * u_xlat8 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat4.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat3.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat3.xy;
    u_xlat3.x = textureLod(_NormalTex, u_xlat3.xy, 0.0).x;
    u_xlat6 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat3.x = u_xlat3.x * u_xlat6 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat3.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat3.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat3.xy;
    u_xlat3.x = textureLod(_NormalTex, u_xlat3.xy, 0.0).x;
    u_xlat6 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat3.x = u_xlat3.x * u_xlat6 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat3.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat4.xy;
    u_xlat4.x = textureLod(_NormalTex, u_xlat4.xy, 0.0).x;
    u_xlat8 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat4.x = u_xlat4.x * u_xlat8 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat4.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
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
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
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
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat4.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat4.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat4.xy;
    u_xlat4.x = textureLod(_NormalTex, u_xlat4.xy, 0.0).x;
    u_xlat8 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat4.x = u_xlat4.x * u_xlat8 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat4.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat0.x * 0.5;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _Shape_Texture_ST;
uniform 	mediump float _ShapeTexChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _Shape_Texture;
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
lowp vec4 u_xlat10_2;
ivec2 u_xlati2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.x = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1 = (-vec4(_ShapeTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _Shape_Texture_ST.xy + _Shape_Texture_ST.zw;
    u_xlat10_2 = texture(_Shape_Texture, u_xlat3.xy);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_ShapeTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
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