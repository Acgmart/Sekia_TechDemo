//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/NormalTransparent_A" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorScale ("MainColorScale", Float) = 1
_AlphaScale ("AlphaScale", Float) = 1
_NormalTex ("NormalTex", 2D) = "white" { }
_NormalTexPanner ("NormalTexPanner", Vector) = (0,0,0,0)
_NormalSale ("NormalSale", Float) = 1
_NormalDistortUVScale ("NormalDistortUVScale", Float) = 0
_SpecUseNormalTex ("SpecUseNormalTex", Range(0, 1)) = 0
_SpecColor ("SpecColor", Color) = (1,1,1,1)
_SpecColor_Scale ("SpecColor_Scale", Float) = 1
_SpecLight_Threshold ("SpecLight_Threshold", Float) = 0.5
_SpecLight_Threshold_Scale ("SpecLight_Threshold_Scale", Float) = 0.7
_FresThreshold ("FresThreshold", Range(0, 1)) = 0.26
_FresnelColor ("FresnelColor", Color) = (1,1,1,1)
_FresnelColorScale ("FresnelColorScale", Float) = 1
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskTexChannelNum ("MaskTexChannelNum", Range(0, 4)) = 1
_MaskTexPanner ("MaskTexPanner", Vector) = (0,0,0,0)
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseChannel ("NoiseChannel", Range(0, 4)) = 1
_NoiseTexChannelScale ("NoiseTexChannelScale", Float) = 1
_NoiseTexPannerXY ("NoiseTexPanner(XY)", Vector) = (0,0,0,0)
_DefinePos ("DefinePos", Vector) = (0,0,0,0)
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
  GpuProgramID 16757
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_16;
vec2 u_xlat18;
float u_xlat26;
void main()
{
    u_xlat16_0.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat18.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat18.xy = _Time.yy * _NormalTexPanner.xy + u_xlat18.xy;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat18.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xy = u_xlat16_8.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat16_4.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_4.xy;
    u_xlat10_2 = texture(_NoiseTex, u_xlat2.xy);
    u_xlat16_2.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat10.xy;
    u_xlat16_1.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat10.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_1.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_10.x;
    u_xlat16_0.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_10.x = u_xlat16_0.x + u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10.x;
    u_xlat16_0.x = u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat10.xyz;
    u_xlat16_8.x = dot(u_xlat10.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz + (-vs_NORMAL0.xyz);
    u_xlat5.xyz = vec3(_SpecUseNormalTex) * u_xlat5.xyz + vs_NORMAL0.xyz;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + (-_FresThreshold);
    u_xlat16_8.x = u_xlat16_8.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_8.x + 0.100000001;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8.x * u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_8.x) + 1.0;
    u_xlat2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat2.x = u_xlat2.x * _MainColor.w;
    u_xlat2.x = u_xlat2.x * _AlphaScale;
    SV_Target0.w = u_xlat2.x;
    u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = vs_TEXCOORD5.xyz * u_xlat2.xxx + u_xlat10.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat2.x + (-_SpecLight_Threshold);
    u_xlat16_8.x = u_xlat16_8.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_8.xxx * _SpecColor.xyz;
    u_xlat16_4.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
int u_xlati24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.x = vs_TEXCOORD6.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD7.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPanner.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.y;
    u_xlat1.y = vs_TEXCOORD8.y;
    u_xlat1.z = vs_TEXCOORD7.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.z;
    u_xlat1.y = vs_TEXCOORD8.z;
    u_xlat1.z = vs_TEXCOORD7.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat0.xyz + (-vs_NORMAL0.xyz);
    u_xlat1.xyz = vec3(_SpecUseNormalTex) * u_xlat1.xyz + vs_NORMAL0.xyz;
    u_xlati24 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat3.xyz = u_xlat1.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyw = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat3.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat3.xyz;
    u_xlat24 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat16_18 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_FresThreshold);
    u_xlat16_18 = u_xlat16_18 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_26 = u_xlat0.x + (-_SpecLight_Threshold);
    u_xlat16_26 = u_xlat16_26 * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _SpecColor.xyz;
    u_xlat16_26 = (-u_xlat16_18) + 1.0;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * _DayColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_5.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_26 = min(abs(_NoiseChannel), 1.0);
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_26;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_8.x;
    u_xlat16_2.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8.x;
    u_xlat16_2.x = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_18 + 0.100000001;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_2.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_18 * u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_16;
vec2 u_xlat18;
float u_xlat26;
void main()
{
    u_xlat16_0.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat18.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat18.xy = _Time.yy * _NormalTexPanner.xy + u_xlat18.xy;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat18.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xy = u_xlat16_8.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat16_4.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_4.xy;
    u_xlat10_2 = texture(_NoiseTex, u_xlat2.xy);
    u_xlat16_2.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat10.xy;
    u_xlat16_1.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat10.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_1.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_10.x;
    u_xlat16_0.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_10.x = u_xlat16_0.x + u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10.x;
    u_xlat16_0.x = u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat10.xyz;
    u_xlat16_8.x = dot(u_xlat10.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz + (-vs_NORMAL0.xyz);
    u_xlat5.xyz = vec3(_SpecUseNormalTex) * u_xlat5.xyz + vs_NORMAL0.xyz;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + (-_FresThreshold);
    u_xlat16_8.x = u_xlat16_8.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_8.x + 0.100000001;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8.x * u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_8.x) + 1.0;
    u_xlat2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat2.x = u_xlat2.x * _MainColor.w;
    u_xlat2.x = u_xlat2.x * _AlphaScale;
    SV_Target0.w = u_xlat2.x;
    u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = vs_TEXCOORD5.xyz * u_xlat2.xxx + u_xlat10.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat2.x + (-_SpecLight_Threshold);
    u_xlat16_8.x = u_xlat16_8.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_8.xxx * _SpecColor.xyz;
    u_xlat16_4.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
int u_xlati24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.x = vs_TEXCOORD6.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD7.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPanner.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.y;
    u_xlat1.y = vs_TEXCOORD8.y;
    u_xlat1.z = vs_TEXCOORD7.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.z;
    u_xlat1.y = vs_TEXCOORD8.z;
    u_xlat1.z = vs_TEXCOORD7.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat0.xyz + (-vs_NORMAL0.xyz);
    u_xlat1.xyz = vec3(_SpecUseNormalTex) * u_xlat1.xyz + vs_NORMAL0.xyz;
    u_xlati24 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat3.xyz = u_xlat1.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyw = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat3.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat3.xyz;
    u_xlat24 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat16_18 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_FresThreshold);
    u_xlat16_18 = u_xlat16_18 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_26 = u_xlat0.x + (-_SpecLight_Threshold);
    u_xlat16_26 = u_xlat16_26 * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _SpecColor.xyz;
    u_xlat16_26 = (-u_xlat16_18) + 1.0;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * _DayColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_5.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_26 = min(abs(_NoiseChannel), 1.0);
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_26;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_8.x;
    u_xlat16_2.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8.x;
    u_xlat16_2.x = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_18 + 0.100000001;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_2.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_18 * u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
mediump float u_xlat16_27;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat8.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat0) + u_xlat8.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat8.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
float u_xlat25;
mediump float u_xlat16_27;
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
    u_xlat8.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlati0 = u_xlati0 << 3;
    u_xlat1.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat1.xyz;
    u_xlat8.xyz = vs_TEXCOORD5.xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat25);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyw = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
mediump float u_xlat16_27;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat8.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat0) + u_xlat8.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat8.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
float u_xlat25;
mediump float u_xlat16_27;
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
    u_xlat8.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlati0 = u_xlati0 << 3;
    u_xlat1.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat1.xyz;
    u_xlat8.xyz = vs_TEXCOORD5.xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat25);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyw = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_16;
vec2 u_xlat18;
float u_xlat26;
void main()
{
    u_xlat16_0.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat18.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat18.xy = _Time.yy * _NormalTexPanner.xy + u_xlat18.xy;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat18.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xy = u_xlat16_8.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat16_4.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_4.xy;
    u_xlat10_2 = texture(_NoiseTex, u_xlat2.xy);
    u_xlat16_2.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat10.xy;
    u_xlat16_1.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat10.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_1.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_10.x;
    u_xlat16_0.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_10.x = u_xlat16_0.x + u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10.x;
    u_xlat16_0.x = u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat10.xyz;
    u_xlat16_8.x = dot(u_xlat10.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz + (-vs_NORMAL0.xyz);
    u_xlat5.xyz = vec3(_SpecUseNormalTex) * u_xlat5.xyz + vs_NORMAL0.xyz;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + (-_FresThreshold);
    u_xlat16_8.x = u_xlat16_8.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_8.x + 0.100000001;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8.x * u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_8.x) + 1.0;
    u_xlat2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat2.x = u_xlat2.x * _MainColor.w;
    u_xlat2.x = u_xlat2.x * _AlphaScale;
    SV_Target0.w = u_xlat2.x;
    u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = vs_TEXCOORD5.xyz * u_xlat2.xxx + u_xlat10.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat2.x + (-_SpecLight_Threshold);
    u_xlat16_8.x = u_xlat16_8.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_8.xxx * _SpecColor.xyz;
    u_xlat16_4.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
int u_xlati24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.x = vs_TEXCOORD6.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD7.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPanner.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.y;
    u_xlat1.y = vs_TEXCOORD8.y;
    u_xlat1.z = vs_TEXCOORD7.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.z;
    u_xlat1.y = vs_TEXCOORD8.z;
    u_xlat1.z = vs_TEXCOORD7.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat0.xyz + (-vs_NORMAL0.xyz);
    u_xlat1.xyz = vec3(_SpecUseNormalTex) * u_xlat1.xyz + vs_NORMAL0.xyz;
    u_xlati24 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat3.xyz = u_xlat1.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyw = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat3.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat3.xyz;
    u_xlat24 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat16_18 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_FresThreshold);
    u_xlat16_18 = u_xlat16_18 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_26 = u_xlat0.x + (-_SpecLight_Threshold);
    u_xlat16_26 = u_xlat16_26 * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _SpecColor.xyz;
    u_xlat16_26 = (-u_xlat16_18) + 1.0;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * _DayColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_5.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_26 = min(abs(_NoiseChannel), 1.0);
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_26;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_8.x;
    u_xlat16_2.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8.x;
    u_xlat16_2.x = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_18 + 0.100000001;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_2.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_18 * u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_16;
vec2 u_xlat18;
float u_xlat26;
void main()
{
    u_xlat16_0.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat18.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat18.xy = _Time.yy * _NormalTexPanner.xy + u_xlat18.xy;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat18.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xy = u_xlat16_8.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat16_4.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat2.xy;
    u_xlat2.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_4.xy;
    u_xlat10_2 = texture(_NoiseTex, u_xlat2.xy);
    u_xlat16_2.xy = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_1.w + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat10.xy;
    u_xlat16_1.xy = u_xlat16_8.xy * vec2(_NormalDistortUVScale) + u_xlat10.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_1.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_10.x;
    u_xlat16_0.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_10.x = u_xlat16_0.x + u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10.x;
    u_xlat16_0.x = u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat10.xyz;
    u_xlat16_8.x = dot(u_xlat10.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz + (-vs_NORMAL0.xyz);
    u_xlat5.xyz = vec3(_SpecUseNormalTex) * u_xlat5.xyz + vs_NORMAL0.xyz;
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + (-_FresThreshold);
    u_xlat16_8.x = u_xlat16_8.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_8.x + 0.100000001;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_0.x) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8.x * u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_8.x) + 1.0;
    u_xlat2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat2.x = u_xlat2.x * _MainColor.w;
    u_xlat2.x = u_xlat2.x * _AlphaScale;
    SV_Target0.w = u_xlat2.x;
    u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat5.xxx + u_xlat6.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = vs_TEXCOORD5.xyz * u_xlat2.xxx + u_xlat10.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat2.x + (-_SpecLight_Threshold);
    u_xlat16_8.x = u_xlat16_8.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_8.xxx * _SpecColor.xyz;
    u_xlat16_4.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
int u_xlati24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.x = vs_TEXCOORD6.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD7.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPanner.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.y;
    u_xlat1.y = vs_TEXCOORD8.y;
    u_xlat1.z = vs_TEXCOORD7.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD6.z;
    u_xlat1.y = vs_TEXCOORD8.z;
    u_xlat1.z = vs_TEXCOORD7.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat0.xyz + (-vs_NORMAL0.xyz);
    u_xlat1.xyz = vec3(_SpecUseNormalTex) * u_xlat1.xyz + vs_NORMAL0.xyz;
    u_xlati24 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat3.xyz = u_xlat1.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyw = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat3.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat3.xyz;
    u_xlat24 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat16_18 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_FresThreshold);
    u_xlat16_18 = u_xlat16_18 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_26 = u_xlat0.x + (-_SpecLight_Threshold);
    u_xlat16_26 = u_xlat16_26 * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _SpecColor.xyz;
    u_xlat16_26 = (-u_xlat16_18) + 1.0;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * _DayColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_5.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_26 = min(abs(_NoiseChannel), 1.0);
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_26;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_3 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_3.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_3.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_3.w + u_xlat16_8.x;
    u_xlat16_2.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8.x;
    u_xlat16_2.x = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_18 + 0.100000001;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_2.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_18 * u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
mediump float u_xlat16_27;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat8.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat0) + u_xlat8.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat8.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
float u_xlat25;
mediump float u_xlat16_27;
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
    u_xlat8.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlati0 = u_xlati0 << 3;
    u_xlat1.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat1.xyz;
    u_xlat8.xyz = vs_TEXCOORD5.xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat25);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyw = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
mediump float u_xlat16_27;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat8.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz * vec3(u_xlat0) + u_xlat8.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat8.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_NORMAL0;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecUseNormalTex;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _SpecLight_Threshold_Scale;
uniform 	mediump float _SpecColor_Scale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_NORMAL0;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump vec2 u_xlat16_16;
mediump float u_xlat16_19;
float u_xlat25;
mediump float u_xlat16_27;
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
    u_xlat8.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlati0 = u_xlati0 << 3;
    u_xlat1.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat1.xyz;
    u_xlat8.xyz = vs_TEXCOORD5.xyz * u_xlat8.xxx + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat25);
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPanner.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD6.x;
    u_xlat2.y = vs_TEXCOORD8.x;
    u_xlat2.z = vs_TEXCOORD7.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-vs_NORMAL0.xyz);
    u_xlat4.xyz = vec3(_SpecUseNormalTex) * u_xlat4.xyz + vs_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyw = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat0 = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat16_19 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = u_xlat16_19 + (-_FresThreshold);
    u_xlat16_19 = u_xlat16_19 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_27 = (-u_xlat16_19) + 1.0;
    u_xlat16_7.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_MaskTexPanner.x, _MaskTexPanner.y) + u_xlat8.xy;
    u_xlat16_7.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat8.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_7.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_27 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_27 + u_xlat16_8.x;
    u_xlat16.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat16.xy;
    u_xlat16.xy = _Time.yy * vec2(_NoiseTexPannerXY.x, _NoiseTexPannerXY.y) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_NoiseTex, u_xlat16.xy);
    u_xlat16_2 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_11 = u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_19 + 0.100000001;
    u_xlat16_16.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_16.x = u_xlat16_16.y + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_3.x + u_xlat16_16.x;
    u_xlat16_16.x = u_xlat16_16.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat16_8.x = u_xlat16_16.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat16_11) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_19 * u_xlat16_8.x + u_xlat16_11;
    u_xlat16_3.x = u_xlat0 + (-_SpecLight_Threshold);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Threshold_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xxx * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecColor_Scale, _SpecColor_Scale, _SpecColor_Scale)) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * _DayColor.xyz;
    u_xlat0 = u_xlat16_8.x * vs_COLOR0.w;
    u_xlat0 = u_xlat0 * _MainColor.w;
    u_xlat0 = u_xlat0 * _AlphaScale;
    SV_Target0.w = u_xlat0;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 86360
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
  GpuProgramID 164953
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
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
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
ivec2 u_xlati5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
vec2 u_xlat12;
ivec2 u_xlati12;
mediump float u_xlat16_15;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalTexPanner.x, _NormalTexPanner.y) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalSale);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat16_15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-_FresThreshold);
    u_xlat16_15 = u_xlat16_15 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 + 0.100000001;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * _NoiseTexPannerXY.xy + u_xlat16_4.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * _MaskTexPanner.xy + u_xlat6.xy;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat6.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_3.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_6.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat16_3.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_3.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6.x;
    u_xlat16_3.x = u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_3.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_15 * u_xlat16_0.x + u_xlat16_3.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat16_3.x = u_xlat0.x * _AlphaScale + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat12.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat12.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati12.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati5.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati12.xy = (-u_xlati12.xy) + u_xlati5.xy;
    u_xlat12.xy = vec2(u_xlati12.xy);
    u_xlat0.xy = u_xlat12.xy * u_xlat0.xy;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati5;
float u_xlat15;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati5 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati5 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xzw;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xzw;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.zwx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.wxz + (-u_xlat4.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
ivec2 u_xlati5;
vec3 u_xlat6;
mediump vec2 u_xlat16_6;
vec2 u_xlat12;
ivec2 u_xlati12;
mediump float u_xlat16_15;
mediump float u_xlat16_21;
void main()
{
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat6.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat6.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalTexPanner.x, _NormalTexPanner.y) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalSale);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat16_15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-_FresThreshold);
    u_xlat16_15 = u_xlat16_15 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 + 0.100000001;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * _NoiseTexPannerXY.xy + u_xlat16_4.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * _MaskTexPanner.xy + u_xlat6.xy;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat6.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_3.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_6.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat16_3.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_3.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6.x;
    u_xlat16_3.x = u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_3.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_15 * u_xlat16_0.x + u_xlat16_3.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat16_3.x = u_xlat0.x * _AlphaScale + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat12.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat12.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati12.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati5.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati12.xy = (-u_xlati12.xy) + u_xlati5.xy;
    u_xlat12.xy = vec2(u_xlati12.xy);
    u_xlat0.xy = u_xlat12.xy * u_xlat0.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
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
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
ivec2 u_xlati5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
vec2 u_xlat12;
ivec2 u_xlati12;
mediump float u_xlat16_15;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].xyz * _DefinePos.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * _DefinePos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * _DefinePos.zzz + u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalTexPanner.x, _NormalTexPanner.y) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalSale);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat16_15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-_FresThreshold);
    u_xlat16_15 = u_xlat16_15 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 + 0.100000001;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * _NoiseTexPannerXY.xy + u_xlat16_4.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * _MaskTexPanner.xy + u_xlat6.xy;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat6.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_3.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_6.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat16_3.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_3.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6.x;
    u_xlat16_3.x = u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_3.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_15 * u_xlat16_0.x + u_xlat16_3.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat16_3.x = u_xlat0.x * _AlphaScale + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat12.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat12.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati12.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati5.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati12.xy = (-u_xlati12.xy) + u_xlati5.xy;
    u_xlat12.xy = vec2(u_xlati12.xy);
    u_xlat0.xy = u_xlat12.xy * u_xlat0.xy;
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
uniform 	vec4 unity_WorldTransformParams;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati5;
float u_xlat15;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati5 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati5 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xzw;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xzw;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.zwx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.wxz + (-u_xlat4.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec2 _MaskTexPanner;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _NormalSale;
uniform 	mediump vec2 _NormalTexPanner;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalDistortUVScale;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump vec3 _DefinePos;
uniform 	mediump float _FresThreshold;
uniform 	mediump vec2 _NoiseTexPannerXY;
uniform 	vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseChannel;
uniform 	mediump float _NoiseTexChannelScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
ivec2 u_xlati5;
vec3 u_xlat6;
mediump vec2 u_xlat16_6;
vec2 u_xlat12;
ivec2 u_xlati12;
mediump float u_xlat16_15;
mediump float u_xlat16_21;
void main()
{
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _DefinePos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * _DefinePos.xxx + u_xlat6.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * _DefinePos.zzz + u_xlat6.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_NormalTexPanner.x, _NormalTexPanner.y) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalSale);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat16_15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-_FresThreshold);
    u_xlat16_15 = u_xlat16_15 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_15 + 0.100000001;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat0.xy;
    u_xlat0.xy = _Time.yy * _NoiseTexPannerXY.xy + u_xlat16_4.xy;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_NoiseChannel)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_NoiseChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_0.x = u_xlat16_0.x * _NoiseTexChannelScale + 0.100000001;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * _MaskTexPanner.xy + u_xlat6.xy;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalDistortUVScale) + u_xlat6.xy;
    u_xlat10_1 = texture(_MaskTex, u_xlat16_3.xy);
    u_xlat16_2 = (-vec4(vec4(_MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum, _MaskTexChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_6.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat16_3.x = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_3.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6.x;
    u_xlat16_3.x = u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_3.x) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_15 * u_xlat16_0.x + u_xlat16_3.x;
    u_xlat0.x = u_xlat16_0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _MainColor.w;
    u_xlat16_3.x = u_xlat0.x * _AlphaScale + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0 = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = u_xlat12.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat12.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati12.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati5.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati12.xy = (-u_xlati12.xy) + u_xlati5.xy;
    u_xlat12.xy = vec2(u_xlati12.xy);
    u_xlat0.xy = u_xlat12.xy * u_xlat0.xy;
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
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}