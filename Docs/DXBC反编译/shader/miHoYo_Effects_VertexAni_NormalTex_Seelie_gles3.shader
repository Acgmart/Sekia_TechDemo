//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/VertexAni_NormalTex_Seelie" {
Properties {
_LerpDebug ("LerpDebug", Range(0, 1)) = 0
_NormalTex ("NormalTex", 2D) = "white" { }
_NormalTexPannerXY ("NormalTexPanner(XY)", Vector) = (0,0,0,0)
_NormalInnerScale ("NormalInnerScale", Range(0, 20)) = 6
_VertexAniRangeXY ("VertexAniRange(XY)", Vector) = (0,0,0,0)
_VertexAniOffset ("VertexAniOffset", Range(0, 1)) = 0.13
_FresnelColor ("FresnelColor", Color) = (1,1,1,1)
_FresnelColorScale ("FresnelColorScale", Float) = 1
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorScale ("MainColorScale", Float) = 1
_LinearRamp ("LinearRamp", Float) = 0
_AlphaScale ("AlphaScale", Float) = 1
_DissolveTex ("DissolveTex", 2D) = "white" { }
_DissolvePannerXY ("DissolvePanner(XY)", Vector) = (0,0,0,0)
_DissolveChannelNum ("DissolveChannelNum", Range(0, 4)) = 1
_DissolveScale ("DissolveScale", Float) = 1
_DissolveRamp ("DissolveRamp", Range(0, 1)) = 0
_OutLineColor ("OutLineColor", Color) = (1,1,1,1)
_OutLineColorScale ("OutLineColorScale", Float) = 1
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
  GpuProgramID 52083
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_10 = u_xlat16_10 + (-_VertexAniOffset);
    u_xlat16_10 = u_xlat16_10 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
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
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + vs_TEXCOORD0.y;
    u_xlat16_6.x = u_xlat16_1.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.y = u_xlat16_6.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.y = min(max(u_xlat16_1.y, 0.0), 1.0);
#else
    u_xlat16_1.y = clamp(u_xlat16_1.y, 0.0, 1.0);
#endif
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_11 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_11) + 1.0;
    u_xlat16_1.y = u_xlat16_1.y * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.xy = u_xlat16_0.xx + (-u_xlat16_1.xy);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_1.y) + u_xlat16_1.x;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_6.y = (-u_xlat0.x) + 1.0;
    u_xlat16_6.xy = max(u_xlat16_6.xy, vec2(0.0, 9.99999975e-05));
    u_xlat16_11 = log2(u_xlat16_6.y);
    u_xlat16_11 = u_xlat16_11 * 10.0;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_11 = min(u_xlat16_11, 1.0);
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat16_11 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat5.xy;
    u_xlat10_5 = texture(_NormalTex, u_xlat5.xy).x;
    u_xlat16_11 = u_xlat10_5 * 2.0 + -1.0;
    u_xlat16_11 = u_xlat16_11 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_3.xyz;
    u_xlat16_5.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_11);
    u_xlat16_3.xyz = vec3(_LerpDebug) * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat4 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_13 = u_xlat16_13 + (-_VertexAniOffset);
    u_xlat16_13 = u_xlat16_13 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(u_xlat3);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
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
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + vs_TEXCOORD0.y;
    u_xlat16_6.x = u_xlat16_1.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.y = u_xlat16_6.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.y = min(max(u_xlat16_1.y, 0.0), 1.0);
#else
    u_xlat16_1.y = clamp(u_xlat16_1.y, 0.0, 1.0);
#endif
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_11 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_11) + 1.0;
    u_xlat16_1.y = u_xlat16_1.y * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.xy = u_xlat16_0.xx + (-u_xlat16_1.xy);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_1.y) + u_xlat16_1.x;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_6.y = (-u_xlat0.x) + 1.0;
    u_xlat16_6.xy = max(u_xlat16_6.xy, vec2(0.0, 9.99999975e-05));
    u_xlat16_11 = log2(u_xlat16_6.y);
    u_xlat16_11 = u_xlat16_11 * 10.0;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_11 = min(u_xlat16_11, 1.0);
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat16_11 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat5.xy;
    u_xlat10_5 = texture(_NormalTex, u_xlat5.xy).x;
    u_xlat16_11 = u_xlat10_5 * 2.0 + -1.0;
    u_xlat16_11 = u_xlat16_11 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_3.xyz;
    u_xlat16_5.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_11);
    u_xlat16_3.xyz = vec3(_LerpDebug) * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_10 = u_xlat16_10 + (-_VertexAniOffset);
    u_xlat16_10 = u_xlat16_10 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0.x = texture(_NormalTex, u_xlat0.xy).x;
    u_xlat16_13 = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_13 = u_xlat16_13 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat4.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD5.xyz;
    u_xlat3.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 10.0;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_13);
    u_xlat16_1.xyz = vec3(_LerpDebug) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_13 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_13 + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_13 = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_13 = (-u_xlat16_13) + vs_TEXCOORD0.y;
    u_xlat16_2.x = -1.0 / _DissolveScale;
    u_xlat16_6 = u_xlat16_13 * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_10 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_13 + -0.150000006;
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_13 = u_xlat16_0.x + (-u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + u_xlat16_6;
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_2.xzw = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_13) * u_xlat16_2.xzw + u_xlat16_1.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_6 * u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat4 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_13 = u_xlat16_13 + (-_VertexAniOffset);
    u_xlat16_13 = u_xlat16_13 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(u_xlat3);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0.x = texture(_NormalTex, u_xlat0.xy).x;
    u_xlat16_13 = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_13 = u_xlat16_13 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat4.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD5.xyz;
    u_xlat3.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 10.0;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_13);
    u_xlat16_1.xyz = vec3(_LerpDebug) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_13 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_13 + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_13 = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_13 = (-u_xlat16_13) + vs_TEXCOORD0.y;
    u_xlat16_2.x = -1.0 / _DissolveScale;
    u_xlat16_6 = u_xlat16_13 * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_10 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_13 + -0.150000006;
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_13 = u_xlat16_0.x + (-u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + u_xlat16_6;
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_2.xzw = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_13) * u_xlat16_2.xzw + u_xlat16_1.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_6 * u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_10 = u_xlat16_10 + (-_VertexAniOffset);
    u_xlat16_10 = u_xlat16_10 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
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
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + vs_TEXCOORD0.y;
    u_xlat16_6.x = u_xlat16_1.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.y = u_xlat16_6.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.y = min(max(u_xlat16_1.y, 0.0), 1.0);
#else
    u_xlat16_1.y = clamp(u_xlat16_1.y, 0.0, 1.0);
#endif
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_11 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_11) + 1.0;
    u_xlat16_1.y = u_xlat16_1.y * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.xy = u_xlat16_0.xx + (-u_xlat16_1.xy);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_1.y) + u_xlat16_1.x;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_6.y = (-u_xlat0.x) + 1.0;
    u_xlat16_6.xy = max(u_xlat16_6.xy, vec2(0.0, 9.99999975e-05));
    u_xlat16_11 = log2(u_xlat16_6.y);
    u_xlat16_11 = u_xlat16_11 * 10.0;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_11 = min(u_xlat16_11, 1.0);
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat16_11 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat5.xy;
    u_xlat10_5 = texture(_NormalTex, u_xlat5.xy).x;
    u_xlat16_11 = u_xlat10_5 * 2.0 + -1.0;
    u_xlat16_11 = u_xlat16_11 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_3.xyz;
    u_xlat16_5.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_11);
    u_xlat16_3.xyz = vec3(_LerpDebug) * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat4 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_13 = u_xlat16_13 + (-_VertexAniOffset);
    u_xlat16_13 = u_xlat16_13 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(u_xlat3);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_5;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
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
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + vs_TEXCOORD0.y;
    u_xlat16_6.x = u_xlat16_1.x + -0.150000006;
    u_xlat16_1.x = u_xlat16_1.x * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.y = u_xlat16_6.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.y = min(max(u_xlat16_1.y, 0.0), 1.0);
#else
    u_xlat16_1.y = clamp(u_xlat16_1.y, 0.0, 1.0);
#endif
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_11 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_11) + 1.0;
    u_xlat16_1.y = u_xlat16_1.y * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_16 + u_xlat16_11;
    u_xlat16_1.xy = u_xlat16_0.xx + (-u_xlat16_1.xy);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_DissolveScale, _DissolveScale));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_1.y) + u_xlat16_1.x;
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_6.y = (-u_xlat0.x) + 1.0;
    u_xlat16_6.xy = max(u_xlat16_6.xy, vec2(0.0, 9.99999975e-05));
    u_xlat16_11 = log2(u_xlat16_6.y);
    u_xlat16_11 = u_xlat16_11 * 10.0;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat16_11 = min(u_xlat16_11, 1.0);
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat16_11 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat5.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat5.xy;
    u_xlat10_5 = texture(_NormalTex, u_xlat5.xy).x;
    u_xlat16_11 = u_xlat10_5 * 2.0 + -1.0;
    u_xlat16_11 = u_xlat16_11 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_3.xyz;
    u_xlat16_5.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_11);
    u_xlat16_3.xyz = vec3(_LerpDebug) * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_10 = u_xlat16_10 + (-_VertexAniOffset);
    u_xlat16_10 = u_xlat16_10 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0.x = texture(_NormalTex, u_xlat0.xy).x;
    u_xlat16_13 = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_13 = u_xlat16_13 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat4.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD5.xyz;
    u_xlat3.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 10.0;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_13);
    u_xlat16_1.xyz = vec3(_LerpDebug) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_13 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_13 + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_13 = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_13 = (-u_xlat16_13) + vs_TEXCOORD0.y;
    u_xlat16_2.x = -1.0 / _DissolveScale;
    u_xlat16_6 = u_xlat16_13 * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_10 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_13 + -0.150000006;
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_13 = u_xlat16_0.x + (-u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + u_xlat16_6;
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_2.xzw = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_13) * u_xlat16_2.xzw + u_xlat16_1.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_6 * u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffset;
uniform 	mediump vec2 _VertexAniRangeXY;
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
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat4 = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_13 = u_xlat16_13 + (-_VertexAniOffset);
    u_xlat16_13 = u_xlat16_13 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * vec3(u_xlat3);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _LinearRamp;
uniform 	mediump float _LerpDebug;
uniform 	mediump vec4 _OutLineColor;
uniform 	mediump float _OutLineColorScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0.x = texture(_NormalTex, u_xlat0.xy).x;
    u_xlat16_13 = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_13 = u_xlat16_13 * _NormalInnerScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(-0.700259507, -0.634590089, -0.588235259) + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat4.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD5.xyz;
    u_xlat3.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_2.x = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 10.0;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat16_13);
    u_xlat16_1.xyz = vec3(_LerpDebug) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_13 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_13 + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_13 = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_13 = (-u_xlat16_13) + vs_TEXCOORD0.y;
    u_xlat16_2.x = -1.0 / _DissolveScale;
    u_xlat16_6 = u_xlat16_13 * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_10 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_13 + -0.150000006;
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_13 = u_xlat16_0.x + (-u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat16_13) + u_xlat16_6;
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_2.xzw = _OutLineColor.xyz * vec3(_OutLineColorScale) + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_13) * u_xlat16_2.xzw + u_xlat16_1.xyz;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_6 * u_xlat0.x;
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
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 69102
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffset;
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
mediump float u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxxy.z) + _VertexAniRangeXY.xxxy.w;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxxy.z;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_10 = u_xlat16_10 + (-_VertexAniOffset);
    u_xlat16_10 = u_xlat16_10 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_2;
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
uniform 	mediump float _VertexAniOffset;
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
mediump float u_xlat16_2;
float u_xlat3;
int u_xlati9;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat3 = (-_VertexAniRangeXY.xxxy.z) + _VertexAniRangeXY.xxxy.w;
    u_xlat0.x = u_xlat0.x * u_xlat3 + _VertexAniRangeXY.xxxy.z;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_10 = u_xlat16_10 + (-_VertexAniOffset);
    u_xlat16_10 = u_xlat16_10 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_2;
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
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
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
  GpuProgramID 140440
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VertexAniOffset;
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat4;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat4 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _VertexAniRangeXY.x;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_13 = u_xlat16_13 + (-_VertexAniOffset);
    u_xlat16_13 = u_xlat16_13 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat3 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform lowp sampler2D _DissolveTex;
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
ivec2 u_xlati2;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
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
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + vs_TEXCOORD0.y;
    u_xlat16_1.x = u_xlat16_1.x * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VertexAniOffset;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat4;
int u_xlati12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_NormalTexPannerXY.x, _NormalTexPannerXY.y) + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat4 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat0.x = u_xlat0.x * u_xlat4 + _VertexAniRangeXY.x;
    u_xlat16_1.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_13 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_13 = u_xlat16_13 + (-_VertexAniOffset);
    u_xlat16_13 = u_xlat16_13 * 7.0;
    u_xlat16_2 = in_TEXCOORD0.y + 0.0199999996;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat3 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolvePannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform 	mediump float _DissolveRamp;
uniform lowp sampler2D _DissolveTex;
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
ivec2 u_xlati2;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolvePannerXY.x, _DissolvePannerXY.y) + u_xlat0.xy;
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
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = _DissolveRamp * 2.0 + -1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + vs_TEXCOORD0.y;
    u_xlat16_1.x = u_xlat16_1.x * 1.60000002;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}