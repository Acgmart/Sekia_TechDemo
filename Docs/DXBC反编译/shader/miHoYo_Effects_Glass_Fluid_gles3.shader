//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Glass_Fluid" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorScale ("MainColorScale", Float) = 1
_AlphaScale ("AlphaScale", Float) = 1
_LinearColor ("LinearColor", Color) = (1,1,1,1)
_LinearColorScale ("LinearColorScale", Float) = 1
_LinearColorOffset ("LinearColorOffset", Range(-1, 1)) = 1
_FluidColor ("FluidColor", Color) = (0.5220588,0.5220588,0.5220588,1)
_FluidColorScale ("FluidColorScale", Float) = 1
_FluidTex ("FluidTex", 2D) = "white" { }
_FluidRPannerXY ("Fluid(R)Panner(XY)", Vector) = (0,0,0,0)
_FluidRScale ("Fluid(R)Scale", Float) = 1
_FluidThickness ("FluidThickness", Range(0, 1)) = 0
_DistortGUV ("Distort(G)UV", Vector) = (1,1,0,0)
_DistortUVScale ("DistortUVScale", Float) = 0
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
  GpuProgramID 24228
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_6.x = (-u_xlat16_2.x) * u_xlat16_6.x + 0.139999986;
    u_xlat16_10 = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat4.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat4.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat4.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).y;
    u_xlat8.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat8.xy;
    u_xlat4.xy = vec2(u_xlat10_4) * vec2(_DistortUVScale) + u_xlat8.xy;
    u_xlat10_4 = texture(_FluidTex, u_xlat4.xy).x;
    u_xlat16_4 = u_xlat10_4 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * u_xlat16_4;
    u_xlat16_2.x = (-u_xlat16_4) * u_xlat16_2.x + u_xlat16_4;
    u_xlat16_6.x = u_xlat16_4 * u_xlat16_6.x + u_xlat0.x;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_4 = u_xlat16_6.x * _MainColor.w;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_10;
    u_xlat16_6.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_3.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_14 = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4 * u_xlat16_2.x;
    u_xlat1.w = u_xlat16_0 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD5.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD6.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FluidColor;
uniform 	mediump float _FluidColorScale;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump float _FluidThickness;
uniform 	mediump vec4 _LinearColor;
uniform 	mediump float _LinearColorScale;
uniform 	mediump float _LinearColorOffset;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_FluidRPannerXY.x, _FluidRPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat10.xy;
    u_xlat10_10 = texture(_FluidTex, u_xlat10.xy).y;
    u_xlat0.xy = vec2(u_xlat10_10) * vec2(_DistortUVScale) + u_xlat0.xy;
    u_xlat10_0 = texture(_FluidTex, u_xlat0.xy).x;
    u_xlat16_0 = u_xlat10_0 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat5.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat5.x = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_7 = (-u_xlat16_2.x) * u_xlat16_7 + 0.139999986;
    u_xlat16_12 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_12 = max(u_xlat16_12, 0.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat5.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + u_xlat16_2.x;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_12 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_0) * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_2.x = _FluidThickness * u_xlat16_2.x + u_xlat16_12;
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_MainColorScale);
    u_xlat16_4.xyz = _FluidColor.xyz * vec3(_FluidColorScale) + (-u_xlat16_3.xyz);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = vs_TEXCOORD0.y + (-_LinearColorOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = _LinearColor.xyz * vec3(_LinearColorScale) + (-u_xlat16_2.xzw);
    u_xlat16_2.xzw = u_xlat16_3.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_7 = u_xlat16_7 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = u_xlat16_0 * u_xlat16_7 + u_xlat5.x;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat0.xzw = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_1 = u_xlat16_7 * _MainColor.w;
    u_xlat16_2.x = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2.x;
    u_xlat0.w = u_xlat16_1 * vs_COLOR0.w;
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
  GpuProgramID 83415
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
  GpuProgramID 153767
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat9 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_5 = (-u_xlat16_2) * u_xlat16_5 + 0.139999986;
    u_xlat16_8 = u_xlat16_5 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2 + u_xlat16_8;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat3.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat3.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).y;
    u_xlat6.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat6.xy = _Time.yy * _FluidRPannerXY.xy + u_xlat6.xy;
    u_xlat3.xy = vec2(u_xlat10_3) * vec2(_DistortUVScale) + u_xlat6.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).x;
    u_xlat16_3 = u_xlat10_3 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5 + u_xlat0.x;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat16_0 = u_xlat16_2 * _MainColor.w;
    u_xlat16_2 = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0.w + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat9 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_5 = (-u_xlat16_2) * u_xlat16_5 + 0.139999986;
    u_xlat16_8 = u_xlat16_5 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2 + u_xlat16_8;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat3.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat3.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).y;
    u_xlat6.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat6.xy = _Time.yy * _FluidRPannerXY.xy + u_xlat6.xy;
    u_xlat3.xy = vec2(u_xlat10_3) * vec2(_DistortUVScale) + u_xlat6.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).x;
    u_xlat16_3 = u_xlat10_3 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5 + u_xlat0.x;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat16_0 = u_xlat16_2 * _MainColor.w;
    u_xlat16_2 = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0.w + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat9 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_5 = (-u_xlat16_2) * u_xlat16_5 + 0.139999986;
    u_xlat16_8 = u_xlat16_5 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2 + u_xlat16_8;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat3.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat3.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).y;
    u_xlat6.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat6.xy = _Time.yy * _FluidRPannerXY.xy + u_xlat6.xy;
    u_xlat3.xy = vec2(u_xlat10_3) * vec2(_DistortUVScale) + u_xlat6.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).x;
    u_xlat16_3 = u_xlat10_3 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5 + u_xlat0.x;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat16_0 = u_xlat16_2 * _MainColor.w;
    u_xlat16_2 = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0.w + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec2 _FluidRPannerXY;
uniform 	vec4 _FluidTex_ST;
uniform 	mediump vec4 _DistortGUV;
uniform 	mediump float _DistortUVScale;
uniform 	mediump float _FluidRScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _FluidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
mediump float u_xlat16_5;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_8;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat9 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_5 = (-u_xlat16_2) * u_xlat16_5 + 0.139999986;
    u_xlat16_8 = u_xlat16_5 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * -10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 0.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2 + u_xlat16_8;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat0.x = (-vs_TEXCOORD7.y) + -0.200000048;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat16_2;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vec2(_Time.y * _DistortGUV.z, _Time.y * _DistortGUV.w);
    u_xlat3.xy = vs_TEXCOORD0.xy * _DistortGUV.xy + u_xlat3.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).y;
    u_xlat6.xy = vs_TEXCOORD0.xy * _FluidTex_ST.xy + _FluidTex_ST.zw;
    u_xlat6.xy = _Time.yy * _FluidRPannerXY.xy + u_xlat6.xy;
    u_xlat3.xy = vec2(u_xlat10_3) * vec2(_DistortUVScale) + u_xlat6.xy;
    u_xlat10_3 = texture(_FluidTex, u_xlat3.xy).x;
    u_xlat16_3 = u_xlat10_3 * _FluidRScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5 + u_xlat0.x;
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    u_xlat16_0 = u_xlat16_2 * _MainColor.w;
    u_xlat16_2 = _MainColor.w * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0.w + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
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