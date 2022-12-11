//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Fresnal_Double" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_InnerFresnal_Scale ("InnerFresnal_Scale", Float) = 0.5
_InnerFresnal_Power ("InnerFresnal_Power", Float) = 1
_OuterFresnal_Scale ("OuterFresnal_Scale", Float) = 1
_OuterFresnal_Power ("OuterFresnal_Power", Float) = 0.27
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTex[Toggle]", Float) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
[Toggle(_MASK_1TEXTOGGLE_ON)] _Mask_1TexToggle ("Mask_1Tex[Toggle]", Float) = 0
_Mask_1Tex ("Mask_1Tex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _Mask_1TexChannelSwitch ("Mask_1TexChannelSwitch", Float) = 0
_Mask_1TexBrightness ("Mask_1TexBrightness", Float) = 0
_Mask_1Tex_Uspeed ("Mask_1Tex_Uspeed", Float) = 0
_Mask_1Tex_Vspeed ("Mask_1Tex_Vspeed", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_VertexColorOFF ("VertexColor OFF", Float) = 0
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_DayColor ("DayColor", Color) = (1,1,1,1)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 35343
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD7.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat3.x = u_xlat3.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * u_xlat3.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
int u_xlati3;
float u_xlat6;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture(_MaskTex, u_xlat0.xz).x;
    u_xlat0.x = u_xlat10_0 * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture(_MaskTex, u_xlat0.xz).x;
    u_xlat0.x = u_xlat10_0 * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
int u_xlati3;
float u_xlat6;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture(_MaskTex, u_xlat0.xz).x;
    u_xlat0.x = u_xlat10_0 * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD7.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat3.x = u_xlat3.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * u_xlat3.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
int u_xlati3;
float u_xlat6;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture(_MaskTex, u_xlat0.xz).x;
    u_xlat0.x = u_xlat10_0 * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture(_MaskTex, u_xlat0.xz).x;
    u_xlat0.x = u_xlat10_0 * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
int u_xlati3;
float u_xlat6;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xzw * _DayColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture(_MaskTex, u_xlat0.xz).x;
    u_xlat0.x = u_xlat10_0 * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlat1 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat1 + vs_COLOR0.wxyz;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati3;
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
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_2);
    u_xlat0.x = u_xlat16_0 * _OuterFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat0.x + 1.0;
    u_xlat0.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _InnerFresnal_Scale;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati3]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat3.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat1.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_Mask_1Tex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6 = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _Mask_1TexBrightness;
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat6 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = (-u_xlat3.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_2);
    u_xlat3.x = u_xlat16_3 * _OuterFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat16_2 = (-_OuterFresnal_Scale) * u_xlat3.x + 1.0;
    u_xlat3.x = max(u_xlat6, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Power;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _InnerFresnal_Scale;
    u_xlat3.x = u_xlat16_2 * u_xlat3.x;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz;
    u_xlat2 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati6]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1 = vec4(_VertexColorOFF) * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 * _MainColor.wxyz;
    u_xlat6 = u_xlat3.x * u_xlat1.x;
    u_xlat1.xyz = vec3(u_xlat1.y * _ColorBrightness, u_xlat1.z * _ColorBrightness, u_xlat1.w * _ColorBrightness);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat3.xz = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat3.xz).x;
    u_xlat3.x = u_xlat10_3 * u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5.x = (-u_xlat1.x) + 1.0;
    u_xlat5.x = max(u_xlat5.x, 9.99999975e-05);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_5;
    u_xlat5.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat9) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat13 + u_xlat9;
    u_xlat4.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat0.zw;
    vs_TEXCOORD7.xy = u_xlat1.zz + u_xlat1.xw;
    return;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = (-vs_COLOR0.wxyz) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + vs_COLOR0.wxyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat5 = (-u_xlat1.x) + 1.0;
    u_xlat5 = max(u_xlat5, 9.99999975e-05);
    u_xlat5 = log2(u_xlat5);
    u_xlat5 = u_xlat5 * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat5);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.yzw = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xyz = vec3(u_xlat0.y * _DayColor.x, u_xlat0.z * _DayColor.y, u_xlat0.w * _DayColor.z);
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat1.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorOFF;
uniform 	vec4 _MainColor;
uniform 	float _InnerFresnal_Scale;
uniform 	float _InnerFresnal_Power;
uniform 	float _OuterFresnal_Scale;
uniform 	float _OuterFresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _Mask_1TexChannelSwitch;
uniform 	float _Mask_1Tex_Uspeed;
uniform 	vec4 _Mask_1Tex_ST;
uniform 	float _Mask_1Tex_Vspeed;
uniform 	float _Mask_1TexBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFresnal_DoubleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnal_Double {
	miHoYoParticlesFresnal_DoubleArray_Type miHoYoParticlesFresnal_DoubleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_1Tex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
float u_xlat16;
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
    u_xlat1 = vs_COLOR0.wxyz * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz;
    u_xlat0 = (-vs_COLOR0.wxyz) * miHoYoParticlesFresnal_DoubleArray[u_xlati0]._MeshParticleColorArray.wxyz + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(_VertexColorOFF) * u_xlat0 + u_xlat1;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat16 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 9.99999975e-05);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _InnerFresnal_Power;
    u_xlat1.y = exp2(u_xlat6.x);
    u_xlat16_3 = (-u_xlat1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat16_3);
    u_xlat1.xy = u_xlat1.xy * vec2(_OuterFresnal_Power, _InnerFresnal_Scale);
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3 = (-_OuterFresnal_Scale) * u_xlat1.x + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat16_3;
    u_xlat0 = u_xlat0 * _MainColor.wxyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_1Tex_ST.xy + _Mask_1Tex_ST.zw;
    u_xlat4.x = _Time.y * _Mask_1Tex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _Mask_1Tex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_Mask_1Tex, u_xlat4.xy);
    u_xlatb3 = equal(vec4(_Mask_1TexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat16 = (u_xlatb3.z) ? u_xlat2.z : u_xlat16;
    u_xlat16 = (u_xlatb3.y) ? u_xlat2.y : u_xlat16;
    u_xlat16 = (u_xlatb3.x) ? u_xlat2.x : u_xlat16;
    u_xlat16 = u_xlat16 * _Mask_1TexBrightness;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6;
    u_xlat0.x = u_xlat16 * u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD7.w);
    u_xlat11 = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat11) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16 + u_xlat11;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat6.x * u_xlat0.x;
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
Keywords { "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_MASKTEXTOGGLE_ON" "_MASK_1TEXTOGGLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}