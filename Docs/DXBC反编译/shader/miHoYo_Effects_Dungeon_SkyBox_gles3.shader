//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Dungeon_SkyBox" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_SkyColor ("SkyColor", Color) = (1,1,1,0)
_TopRange ("TopRange", Range(1, 3)) = 3
_CloudSpeed ("CloudSpeed", Range(-0.5, 0.5)) = 0
_Normal ("Normal", 2D) = "bump" { }
_AirflowIntensity ("AirflowIntensity", Range(0, 0.1)) = 0
_LightningColor ("LightningColor", Color) = (1,1,1,0)
_LightningRange ("LightningRange", Range(1, 3)) = 2.5
_LightningSpeed ("LightningSpeed", Range(0, 1)) = 0.7
_LightningInterval ("LightningInterval", Range(0.85, 0.98)) = 0.85
_LightningMask ("LightningMask", 2D) = "white" { }
_BottomColor ("BottomColor", Color) = (0.3109321,0.3735421,0.5220588,0)
_ButtomRange ("ButtomRange", Range(0, 3)) = 1
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
  GpuProgramID 55848
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
uniform 	vec4 _Time;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat10;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = _Time.y * _LightningSpeed;
    u_xlat16_1.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x + (-_LightningInterval);
    u_xlat16_6 = (-_LightningInterval) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = fract(_Time.z);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightningColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_Normal, u_xlat0.xy).xy;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.x = _Time.y * _CloudSpeed;
    u_xlat0.xy = u_xlat10.xx * vec2(1.0, 0.0) + u_xlat0.xy;
    u_xlat10.xy = u_xlat10.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat10.xy).xyz;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat16_16 = max(u_xlat10_0.z, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _LightningRange;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_15 = texture(_LightningMask, u_xlat4.xy).x;
    u_xlat16_15 = u_xlat10_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_15) + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_16 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlat16_0.xyz = u_xlat10_3.xyz * vec3(u_xlat16_16);
    u_xlat16_2.xyz = u_xlat16_0.xyz * _SkyColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _SkyColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_16 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_16 = u_xlat16_16 * 6.66666651;
    u_xlat16_17 = float(1.0) / _TopRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    u_xlat16_16 = min(u_xlat16_16, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BottomColor.xyz;
    u_xlat16_16 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 10.0;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_17 = float(1.0) / _ButtomRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    SV_Target0.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _Time;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat10;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = _Time.y * _LightningSpeed;
    u_xlat16_1.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x + (-_LightningInterval);
    u_xlat16_6 = (-_LightningInterval) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = fract(_Time.z);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightningColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_Normal, u_xlat0.xy).xy;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.x = _Time.y * _CloudSpeed;
    u_xlat0.xy = u_xlat10.xx * vec2(1.0, 0.0) + u_xlat0.xy;
    u_xlat10.xy = u_xlat10.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat10.xy).xyz;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat16_16 = max(u_xlat10_0.z, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _LightningRange;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_15 = texture(_LightningMask, u_xlat4.xy).x;
    u_xlat16_15 = u_xlat10_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_15) + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_16 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlat16_0.xyz = u_xlat10_3.xyz * vec3(u_xlat16_16);
    u_xlat16_2.xyz = u_xlat16_0.xyz * _SkyColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _SkyColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_16 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_16 = u_xlat16_16 * 6.66666651;
    u_xlat16_17 = float(1.0) / _TopRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    u_xlat16_16 = min(u_xlat16_16, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BottomColor.xyz;
    u_xlat16_16 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 10.0;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_17 = float(1.0) / _ButtomRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    SV_Target0.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat6;
lowp vec3 u_xlat10_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
mediump float u_xlat16_17;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat10 = _Time.y * _CloudSpeed;
    u_xlat1.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyw = u_xlat10_0.xyw * u_xlat16_2.xxx;
    u_xlat1.x = _Time.y * _LightningSpeed;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_2.x = u_xlat16_2.x + (-_LightningInterval);
    u_xlat16_7 = (-_LightningInterval) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.x = fract(_Time.z);
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat6.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + u_xlat3.xy;
    u_xlat10_6.xy = texture(_Normal, u_xlat6.xy).xy;
    u_xlat16_2.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat3.xy;
    u_xlat10_6.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_10 = texture(_LightningMask, u_xlat3.xy).x;
    u_xlat16_10 = u_xlat10_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat1.xxx * _LightningColor.xyz;
    u_xlat16_17 = max(u_xlat10_6.z, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _LightningRange;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_17 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_17 = u_xlat16_17 * 6.66666651;
    u_xlat16_4.x = float(1.0) / _TopRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_17 = min(u_xlat16_17, 1.0);
    u_xlat16_4.xyz = u_xlat16_0.xyw * _SkyColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat10_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SkyColor.xyz + (-u_xlat16_4.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_17 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = max(u_xlat16_17, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * 10.0;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_4.x = float(1.0) / _ButtomRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + _BottomColor.xyz;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat6;
lowp vec3 u_xlat10_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
mediump float u_xlat16_17;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat10 = _Time.y * _CloudSpeed;
    u_xlat1.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyw = u_xlat10_0.xyw * u_xlat16_2.xxx;
    u_xlat1.x = _Time.y * _LightningSpeed;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_2.x = u_xlat16_2.x + (-_LightningInterval);
    u_xlat16_7 = (-_LightningInterval) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.x = fract(_Time.z);
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat6.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + u_xlat3.xy;
    u_xlat10_6.xy = texture(_Normal, u_xlat6.xy).xy;
    u_xlat16_2.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat3.xy;
    u_xlat10_6.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_10 = texture(_LightningMask, u_xlat3.xy).x;
    u_xlat16_10 = u_xlat10_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat1.xxx * _LightningColor.xyz;
    u_xlat16_17 = max(u_xlat10_6.z, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _LightningRange;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_17 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_17 = u_xlat16_17 * 6.66666651;
    u_xlat16_4.x = float(1.0) / _TopRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_17 = min(u_xlat16_17, 1.0);
    u_xlat16_4.xyz = u_xlat16_0.xyw * _SkyColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat10_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SkyColor.xyz + (-u_xlat16_4.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_17 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = max(u_xlat16_17, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * 10.0;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_4.x = float(1.0) / _ButtomRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + _BottomColor.xyz;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
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
uniform 	vec4 _Time;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat10;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = _Time.y * _LightningSpeed;
    u_xlat16_1.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x + (-_LightningInterval);
    u_xlat16_6 = (-_LightningInterval) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = fract(_Time.z);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightningColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_Normal, u_xlat0.xy).xy;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.x = _Time.y * _CloudSpeed;
    u_xlat0.xy = u_xlat10.xx * vec2(1.0, 0.0) + u_xlat0.xy;
    u_xlat10.xy = u_xlat10.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat10.xy).xyz;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat16_16 = max(u_xlat10_0.z, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _LightningRange;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_15 = texture(_LightningMask, u_xlat4.xy).x;
    u_xlat16_15 = u_xlat10_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_15) + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_16 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlat16_0.xyz = u_xlat10_3.xyz * vec3(u_xlat16_16);
    u_xlat16_2.xyz = u_xlat16_0.xyz * _SkyColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _SkyColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_16 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_16 = u_xlat16_16 * 6.66666651;
    u_xlat16_17 = float(1.0) / _TopRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    u_xlat16_16 = min(u_xlat16_16, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BottomColor.xyz;
    u_xlat16_16 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 10.0;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_17 = float(1.0) / _ButtomRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    SV_Target0.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _Time;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat10;
mediump float u_xlat16_15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = _Time.y * _LightningSpeed;
    u_xlat16_1.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x + (-_LightningInterval);
    u_xlat16_6 = (-_LightningInterval) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = fract(_Time.z);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightningColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_Normal, u_xlat0.xy).xy;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.x = _Time.y * _CloudSpeed;
    u_xlat0.xy = u_xlat10.xx * vec2(1.0, 0.0) + u_xlat0.xy;
    u_xlat10.xy = u_xlat10.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat10.xy).xyz;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat16_16 = max(u_xlat10_0.z, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _LightningRange;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_15 = texture(_LightningMask, u_xlat4.xy).x;
    u_xlat16_15 = u_xlat10_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_15) + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_16 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_16 = sqrt(u_xlat16_16);
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlat16_0.xyz = u_xlat10_3.xyz * vec3(u_xlat16_16);
    u_xlat16_2.xyz = u_xlat16_0.xyz * _SkyColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _SkyColor.xyz + (-u_xlat16_2.xyz);
    u_xlat16_16 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_16 = u_xlat16_16 * 6.66666651;
    u_xlat16_17 = float(1.0) / _TopRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    u_xlat16_16 = min(u_xlat16_16, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BottomColor.xyz;
    u_xlat16_16 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat16_16 = max(u_xlat16_16, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 10.0;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_17 = float(1.0) / _ButtomRange;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_16 * -2.0 + 3.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_17;
    SV_Target0.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat6;
lowp vec3 u_xlat10_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
mediump float u_xlat16_17;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat10 = _Time.y * _CloudSpeed;
    u_xlat1.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyw = u_xlat10_0.xyw * u_xlat16_2.xxx;
    u_xlat1.x = _Time.y * _LightningSpeed;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_2.x = u_xlat16_2.x + (-_LightningInterval);
    u_xlat16_7 = (-_LightningInterval) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.x = fract(_Time.z);
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat6.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + u_xlat3.xy;
    u_xlat10_6.xy = texture(_Normal, u_xlat6.xy).xy;
    u_xlat16_2.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat3.xy;
    u_xlat10_6.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_10 = texture(_LightningMask, u_xlat3.xy).x;
    u_xlat16_10 = u_xlat10_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat1.xxx * _LightningColor.xyz;
    u_xlat16_17 = max(u_xlat10_6.z, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _LightningRange;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_17 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_17 = u_xlat16_17 * 6.66666651;
    u_xlat16_4.x = float(1.0) / _TopRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_17 = min(u_xlat16_17, 1.0);
    u_xlat16_4.xyz = u_xlat16_0.xyw * _SkyColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat10_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SkyColor.xyz + (-u_xlat16_4.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_17 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = max(u_xlat16_17, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * 10.0;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_4.x = float(1.0) / _ButtomRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + _BottomColor.xyz;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _CloudSpeed;
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _LightningColor;
uniform 	mediump float _LightningSpeed;
uniform 	mediump float _LightningInterval;
uniform 	mediump float _AirflowIntensity;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _LightningRange;
uniform 	vec4 _LightningMask_ST;
uniform 	mediump float _TopRange;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _ButtomRange;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Normal;
uniform lowp sampler2D _LightningMask;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat6;
lowp vec3 u_xlat10_6;
mediump float u_xlat16_7;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
mediump float u_xlat16_17;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat10 = _Time.y * _CloudSpeed;
    u_xlat1.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyw = u_xlat10_0.xyw * u_xlat16_2.xxx;
    u_xlat1.x = _Time.y * _LightningSpeed;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_2.x = u_xlat16_2.x + (-_LightningInterval);
    u_xlat16_7 = (-_LightningInterval) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.x = fract(_Time.z);
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(vec2(_CloudSpeed, _CloudSpeed)) + u_xlat6.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xy = vec2(u_xlat10) * vec2(1.0, 0.0) + u_xlat3.xy;
    u_xlat10_6.xy = texture(_Normal, u_xlat6.xy).xy;
    u_xlat16_2.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_AirflowIntensity, _AirflowIntensity)) + u_xlat3.xy;
    u_xlat10_6.xyz = texture(_MainTex, u_xlat16_2.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _LightningMask_ST.xy + _LightningMask_ST.zw;
    u_xlat10_10 = texture(_LightningMask, u_xlat3.xy).x;
    u_xlat16_10 = u_xlat10_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat1.xxx * _LightningColor.xyz;
    u_xlat16_17 = max(u_xlat10_6.z, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _LightningRange;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat16_17 = (-vs_TEXCOORD0.y) + 0.850000024;
    u_xlat16_17 = u_xlat16_17 * 6.66666651;
    u_xlat16_4.x = float(1.0) / _TopRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_17 = min(u_xlat16_17, 1.0);
    u_xlat16_4.xyz = u_xlat16_0.xyw * _SkyColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat10_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _SkyColor.xyz + (-u_xlat16_4.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_17 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_17 = (-u_xlat16_17) + 1.0;
    u_xlat16_17 = max(u_xlat16_17, 9.99999975e-05);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * 10.0;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_4.x = float(1.0) / _ButtomRange;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + _BottomColor.xyz;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
  GpuProgramID 108655
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
  GpuProgramID 131074
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

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
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-_MotionVectorsAlphaCutoff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
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
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-_MotionVectorsAlphaCutoff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
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
Keywords { "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}