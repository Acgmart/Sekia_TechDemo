//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Afs Simple Tree v4/BillBoard" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_ForwardDiffuseStrength ("Forward Diffuse Strength", Range(0, 1)) = 0.8
_ForwardDiffuseOffset ("Forward Diffuse Offset", Range(-1, 1)) = 0.1
_BackDiffuseStrength ("Back Diffuse Strength", Range(0, 1)) = 0.75
_BackDiffuseOffset ("Back Diffuse Offset", Range(-1, 1)) = 0.1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_VerticalBillBoarding ("Vertical Restraints", Range(-1, 1)) = 0.2
_SpecularReflectivity ("Shininess", Range(0.001, 1)) = 0.1
_Gloss ("Gloss", Range(0.001, 1)) = 0.1
_SpecularReflectivityColor ("ShininessColor", Color) = (1,1,1,1)
_LTDistortion ("Distortion _LT", Range(0, 2)) = 0
_LTPower ("Power _LT", Range(0, 50)) = 1
_LTScale ("Scale _LT", Range(0, 1)) = 1
[Toggle(BILLBOARD_COMBINE_ON)] _BillboradCombineOn ("Billboard combine", Float) = 0
}
SubShader {
 Pass {
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" }
  GpuProgramID 28731
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _ForwardDiffuseOffset;
uniform 	float _BackDiffuseStrength;
uniform 	float _BackDiffuseOffset;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat0 = u_xlat10_0 * _Color;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_14 + 9.99999975e-05;
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat3.x = _SpecularReflectivity * 128.0;
    u_xlat13 = u_xlat16_13 * u_xlat3.x;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = u_xlat13 * _Gloss;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat13 * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularReflectivityColor.xyz;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat5 = _ForwardDiffuseOffset + (-_BackDiffuseOffset);
    u_xlat5 = vs_TEXCOORD5.w * u_xlat5 + _BackDiffuseOffset;
    u_xlat1.x = u_xlat16_2.x * u_xlat1.x + u_xlat5;
    u_xlat16_2.x = u_xlat1.x * 0.600000024 + 0.400000006;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * _LightColor0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _ForwardDiffuseOffset;
uniform 	float _BackDiffuseStrength;
uniform 	float _BackDiffuseOffset;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat0 = u_xlat10_0 * _Color;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_14 + 9.99999975e-05;
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat3.x = _SpecularReflectivity * 128.0;
    u_xlat13 = u_xlat16_13 * u_xlat3.x;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = u_xlat13 * _Gloss;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat13 * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularReflectivityColor.xyz;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat5 = _ForwardDiffuseOffset + (-_BackDiffuseOffset);
    u_xlat5 = vs_TEXCOORD5.w * u_xlat5 + _BackDiffuseOffset;
    u_xlat1.x = u_xlat16_2.x * u_xlat1.x + u_xlat5;
    u_xlat16_2.x = u_xlat1.x * 0.600000024 + 0.400000006;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * _LightColor0.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _ForwardDiffuseOffset;
uniform 	float _BackDiffuseStrength;
uniform 	float _BackDiffuseOffset;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat0 = u_xlat10_0 * _Color;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_14 + 9.99999975e-05;
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat3.x = _SpecularReflectivity * 128.0;
    u_xlat13 = u_xlat16_13 * u_xlat3.x;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = u_xlat13 * _Gloss;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat13 * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularReflectivityColor.xyz;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat5 = _ForwardDiffuseOffset + (-_BackDiffuseOffset);
    u_xlat5 = vs_TEXCOORD5.w * u_xlat5 + _BackDiffuseOffset;
    u_xlat1.x = u_xlat16_2.x * u_xlat1.x + u_xlat5;
    u_xlat16_2.x = u_xlat1.x * 0.600000024 + 0.400000006;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * _LightColor0.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _ForwardDiffuseOffset;
uniform 	float _BackDiffuseStrength;
uniform 	float _BackDiffuseOffset;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat0 = u_xlat10_0 * _Color;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_14 + 9.99999975e-05;
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat3.x = _SpecularReflectivity * 128.0;
    u_xlat13 = u_xlat16_13 * u_xlat3.x;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = u_xlat13 * _Gloss;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat13 * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularReflectivityColor.xyz;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat5 = _ForwardDiffuseOffset + (-_BackDiffuseOffset);
    u_xlat5 = vs_TEXCOORD5.w * u_xlat5 + _BackDiffuseOffset;
    u_xlat1.x = u_xlat16_2.x * u_xlat1.x + u_xlat5;
    u_xlat16_2.x = u_xlat1.x * 0.600000024 + 0.400000006;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * _LightColor0.xyz + u_xlat1.xyz;
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
Keywords { "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "BILLBOARD_COMBINE_ON" }
""
}
}
}
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "DebugView" = "On" "DisableBatching" = "true" "LIGHTMODE" = "HYBRIDDEFERRED" }
  GpuProgramID 97657
Program "vp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
mediump vec2 u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_3.xy + _treeLOD2UVSscaleAndOffset.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_3.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_11.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_11.x = inversesqrt(u_xlat16_11.x);
    u_xlat16_11.xy = u_xlat16_11.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_11.xy);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_3.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
int u_xlati5;
float u_xlat10;
bool u_xlatb10;
mediump vec2 u_xlat16_14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb10 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb10)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat3.x = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
mediump vec2 u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_3.xy + _treeLOD2UVSscaleAndOffset.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_3.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_11.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_11.x = inversesqrt(u_xlat16_11.x);
    u_xlat16_11.xy = u_xlat16_11.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_11.xy);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_3.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
int u_xlati5;
float u_xlat10;
bool u_xlatb10;
mediump vec2 u_xlat16_14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb10 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb10)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat3.x = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat5 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb15 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb15)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat5.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat5.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat5.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat5.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat5 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb15 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb15)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat5.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat5.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat5.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat5.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec2 u_xlat16_16;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + _treeLOD2UVSscaleAndOffset.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat5.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat5.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat5.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    vs_TEXCOORD1.y = u_xlat5.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat5.y;
    vs_TEXCOORD3.y = u_xlat5.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_16.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_16.x = inversesqrt(u_xlat16_16.x);
    u_xlat16_16.xy = u_xlat16_16.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_16.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
int u_xlati6;
float u_xlat12;
bool u_xlatb12;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat12 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_5.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_5.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat0.xzw = u_xlat1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat1.zzz + u_xlat0.xzw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat1.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat1.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat1.x);
    vs_TEXCOORD1.w = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat2.y;
    vs_TEXCOORD2.x = (-u_xlat1.y);
    vs_TEXCOORD3.x = (-u_xlat1.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
mediump vec2 u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_3.xy + _treeLOD2UVSscaleAndOffset.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_3.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_11.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_11.x = inversesqrt(u_xlat16_11.x);
    u_xlat16_11.xy = u_xlat16_11.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_11.xy);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_3.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
int u_xlati5;
float u_xlat10;
bool u_xlatb10;
mediump vec2 u_xlat16_14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb10 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb10)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat3.x = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
mediump vec2 u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_3.xy + _treeLOD2UVSscaleAndOffset.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_3.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_11.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_11.x = inversesqrt(u_xlat16_11.x);
    u_xlat16_11.xy = u_xlat16_11.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_11.xy);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_3.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
int u_xlati5;
float u_xlat10;
bool u_xlatb10;
mediump vec2 u_xlat16_14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb10 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb10)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat2.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat16_4.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
    u_xlat3.x = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(u_xlat1.xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat16;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_LTDistortion);
    SV_Target0.w = 0.00784313772;
    u_xlat16 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16) + u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16);
    u_xlat1.x = dot(u_xlat3.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x + 9.99999975e-05;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _LTPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_6 = _LTScale * 25.0;
    u_xlat16_2.x = u_xlat16_6 * u_xlat1.x + -1.0;
    u_xlat16_7 = (-u_xlat10_0.w) + 1.0;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_2.x * 0.0399999991;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00999999978);
    SV_Target1.w = min(u_xlat16_2.x, 1.0);
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat5.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat5.z;
    SV_Target2.xy = u_xlat5.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _LTDistortion;
uniform 	mediump float _LTPower;
uniform 	mediump float _LTScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec4 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat14;
bvec3 u_xlatb14;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat34;
mediump float u_xlat16_38;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1.x){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = max(u_xlat1.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb1.x){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21.x = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat1.x = max(u_xlat1.x, u_xlat21.x);
        u_xlat1.x = log2(u_xlat1.x);
        u_xlat1.x = u_xlat1.x * 0.5;
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.x = u_xlat1.x + 1.0;
        u_xlat11.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat1.x = u_xlat11.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(256.0<u_xlat1.x);
#else
        u_xlatb11 = 256.0<u_xlat1.x;
#endif
        u_xlatb1.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat1.xxxx).xz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb1.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (bool(u_xlatb11)) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb1.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb1.x){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat2.xy = _MainTex_TexelSize.zw;
        u_xlat2.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb2 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat3.x = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat13.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat13.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat13.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat13.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat12.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat12.zx);
            u_xlat12.z = inversesqrt(u_xlat12.z);
            u_xlat12.x = inversesqrt(u_xlat12.x);
            u_xlat2.xz = u_xlat12.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat12.x = u_xlat3.y * u_xlat3.x;
            u_xlat22 = u_xlat2.x * u_xlat12.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat32 = fract((-u_xlat3.x));
            u_xlat32 = u_xlat32 + 0.5;
            u_xlat32 = floor(u_xlat32);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat32 = u_xlat32 + (-u_xlat3.x);
            u_xlat32 = u_xlat32 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat12.x) * u_xlat2.x + 1.0;
            u_xlat13.xyz = (-vec3(u_xlat32)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat13.xyz + vec3(u_xlat32);
            u_xlatb3.xy = lessThan(vec4(u_xlat22), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat32) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat12.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat13.zyy + vec3(u_xlat32);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb32)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat32 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat5.x = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat32 = max(u_xlat32, u_xlat5.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat5.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = u_xlat4 * u_xlat5.xxxx;
                u_xlat4 = u_xlat4 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat14 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat34 = sqrt(u_xlat32);
                u_xlat5.x = sqrt(u_xlat14);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.z);
                u_xlat14 = inversesqrt(u_xlat14);
                u_xlat4.x = u_xlat14 * abs(u_xlat4.x);
                u_xlat32 = u_xlat32 * u_xlat4.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat4.x = u_xlat34 * u_xlat5.x;
                u_xlat14 = u_xlat32 * u_xlat4.x;
                u_xlat24.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat5.x = fract((-u_xlat24.x));
                u_xlat5.x = u_xlat5.x + 0.5;
                u_xlat5.x = floor(u_xlat5.x);
                u_xlat24.xy = fract(u_xlat24.xy);
                u_xlat24.xy = u_xlat24.xy + vec2(0.5, 0.5);
                u_xlat24.xy = floor(u_xlat24.xy);
                u_xlat5.x = (-u_xlat24.x) + u_xlat5.x;
                u_xlat24.x = u_xlat5.x * u_xlat24.y + u_xlat24.x;
                u_xlat34 = (-u_xlat4.x) * u_xlat32 + 1.0;
                u_xlat5.xyz = (-u_xlat24.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat24.xxx;
                u_xlatb14.xz = lessThan(vec4(u_xlat14), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat7.xyz = u_xlat24.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat4.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat32) * u_xlat5.zyy + u_xlat24.xxx;
                u_xlat4.xzw = (u_xlatb14.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb14.x) ? u_xlat6.xyz : u_xlat4.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat24.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat24.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat24.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = u_xlat24.xx * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat24.xx;
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat14 = sqrt(u_xlat32);
                    u_xlat24.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat24.x * u_xlat14;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat4.x = fract((-u_xlat21.x));
                    u_xlat4.x = u_xlat4.x + 0.5;
                    u_xlat4.x = floor(u_xlat4.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                    u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb4.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb4.w) ? u_xlat6.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb4.x) ? u_xlat5.xyz : u_xlat1.xyz;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat3.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat3.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat3.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat32);
                    u_xlat31 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat31);
                    u_xlat3.x = sqrt(u_xlat11.x);
                    u_xlat11.z = inversesqrt(u_xlat31);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.xz = u_xlat11.xz * abs(u_xlat1.xz);
                    u_xlat1.x = u_xlat1.x * u_xlat1.z;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat32 * u_xlat3.x;
                    u_xlat21.x = u_xlat1.x * u_xlat11.x;
                    u_xlat3.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat31 = fract((-u_xlat3.x));
                    u_xlat31 = u_xlat31 + 0.5;
                    u_xlat31 = floor(u_xlat31);
                    u_xlat3.xy = fract(u_xlat3.xy);
                    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
                    u_xlat3.xy = floor(u_xlat3.xy);
                    u_xlat31 = u_xlat31 + (-u_xlat3.x);
                    u_xlat31 = u_xlat31 * u_xlat3.y + u_xlat3.x;
                    u_xlat32 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-vec3(u_xlat31)) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + vec3(u_xlat31);
                    u_xlatb3.xw = lessThan(u_xlat21.xxxx, vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = vec3(u_xlat31) * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + vec3(u_xlat31);
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb1.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat1.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat1.x = vs_TEXCOORD5.w * u_xlat1.x + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = u_xlat1.xxx * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    u_xlat16_38 = (-u_xlat10_0.w) + 1.0;
    u_xlat30 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = sqrt(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat31);
    u_xlat16_2.xyz = u_xlat16_8.xyz * vec3(_LTDistortion);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + 9.99999975e-05;
    u_xlat30 = log2(u_xlat30);
    u_xlat30 = u_xlat30 * _LTPower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat16_1 = _LTScale * 25.0;
    u_xlat16_9.x = u_xlat16_1 * u_xlat30 + -1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x + 1.0;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    u_xlat16_38 = u_xlat16_38 + -1.0;
    u_xlat16_38 = u_xlat16_38 * 0.0399999991;
    u_xlat16_38 = max(u_xlat16_38, 0.00999999978);
    SV_Target1.w = min(u_xlat16_38, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat9<0.0);
#else
    u_xlatb0 = u_xlat9<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_10);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0.x = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0.x = vs_TEXCOORD5.w * u_xlat0.x + _BackDiffuseStrength;
    SV_Target1.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat3.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat3.z;
    SV_Target2.xy = u_xlat3.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat6 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.w = u_xlat1.x;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].zxy;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].zxy * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].zxy * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat6.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat6.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat6.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat6.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat6.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat6.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = u_xlat6.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zxy;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zxy * u_xlat6.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zxy * u_xlat6.zzz + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.999000013<abs(u_xlat0.z));
#else
    u_xlatb18 = 0.999000013<abs(u_xlat0.z);
#endif
    u_xlat3.xyz = (bool(u_xlatb18)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.zxy * u_xlat0.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD1.x = (-u_xlat3.x);
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD2.x = (-u_xlat3.y);
    vs_TEXCOORD3.x = (-u_xlat3.z);
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xy = u_xlat16_5.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_17.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_17.x = inversesqrt(u_xlat16_17.x);
    u_xlat16_17.xy = u_xlat16_17.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_5.x = dot(u_xlat16_5.xy, u_xlat16_17.xy);
    u_xlat16_5.x = u_xlat16_5.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_5.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
bvec3 u_xlatb12;
vec3 u_xlat14;
vec2 u_xlat21;
vec2 u_xlat22;
float u_xlat24;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
float u_xlat34;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat30 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<0.0);
#else
    u_xlatb30 = u_xlat30<0.0;
#endif
    if((int(u_xlatb30) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb30){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb30){
        u_xlat30 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = max(u_xlat30, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb30){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat21.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat30 = dot(u_xlat21.xy, u_xlat21.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat30 = max(u_xlat30, u_xlat1.x);
        u_xlat30 = log2(u_xlat30);
        u_xlat30 = u_xlat30 * 0.5;
        u_xlat30 = max(u_xlat30, 0.0);
        u_xlat30 = u_xlat30 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat30 = u_xlat1.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat30);
#else
        u_xlatb1.x = 256.0<u_xlat30;
#endif
        u_xlatb11.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat30)).xy;
        u_xlat2 = (u_xlatb11.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb11.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb30 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb30){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb30)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb30 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb30){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat30 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat30 = max(u_xlat30, u_xlat3.x);
            u_xlat30 = log2(u_xlat30);
            u_xlat30 = u_xlat30 * 0.5;
            u_xlat30 = max(u_xlat30, 0.0);
            u_xlat30 = u_xlat30 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat30);
            u_xlat30 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat12 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat32 = sqrt(u_xlat30);
            u_xlat3.x = sqrt(u_xlat12);
            u_xlat30 = inversesqrt(u_xlat30);
            u_xlat30 = u_xlat30 * abs(u_xlat2.z);
            u_xlat12 = inversesqrt(u_xlat12);
            u_xlat2.x = u_xlat12 * abs(u_xlat2.x);
            u_xlat30 = u_xlat30 * u_xlat2.x;
            u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
            u_xlat30 = sqrt(u_xlat30);
            u_xlat2.x = u_xlat32 * u_xlat3.x;
            u_xlat12 = u_xlat30 * u_xlat2.x;
            u_xlat22.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat22.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat22.xy = fract(u_xlat22.xy);
            u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
            u_xlat22.xy = floor(u_xlat22.xy);
            u_xlat3.x = (-u_xlat22.x) + u_xlat3.x;
            u_xlat22.x = u_xlat3.x * u_xlat22.y + u_xlat22.x;
            u_xlat32 = (-u_xlat2.x) * u_xlat30 + 1.0;
            u_xlat3.xyz = (-u_xlat22.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat22.xxx;
            u_xlatb12.xz = lessThan(vec4(u_xlat12), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat22.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat30 = u_xlat2.x * u_xlat30 + -4.0;
            u_xlat30 = exp2(u_xlat30);
            u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
            u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat22.xxx;
            u_xlat2.xzw = (u_xlatb12.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb12.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _BumpMap_TexelSize.zwzz).xy;
            u_xlatb30 = u_xlatb3.y || u_xlatb3.x;
            u_xlat3.xy = _BumpMap_TexelSize.zw;
            u_xlat3.zw = vs_TEXCOORD0.xy;
            u_xlat3 = (bool(u_xlatb30)) ? u_xlat3 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb30 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb30 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb30){
                u_xlat4.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                u_xlat4.zw = dFdx(u_xlat4.xy);
                u_xlat4.xy = dFdy(u_xlat4.xy);
                u_xlat30 = dot(u_xlat4.zw, u_xlat4.zw);
                u_xlat32 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat30 = max(u_xlat30, u_xlat32);
                u_xlat30 = log2(u_xlat30);
                u_xlat30 = u_xlat30 * 0.5;
                u_xlat30 = max(u_xlat30, 0.0);
                u_xlat30 = u_xlat30 + 1.0;
                u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4 = vec4(u_xlat32) * u_xlat4;
                u_xlat4 = u_xlat4 / vec4(u_xlat30);
                u_xlat30 = dot(abs(u_xlat4.zw), abs(u_xlat4.zw));
                u_xlat32 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat14.x = sqrt(u_xlat30);
                u_xlat34 = sqrt(u_xlat32);
                u_xlat30 = inversesqrt(u_xlat30);
                u_xlat30 = u_xlat30 * abs(u_xlat4.z);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat4.x);
                u_xlat30 = u_xlat30 * u_xlat32;
                u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                u_xlat30 = sqrt(u_xlat30);
                u_xlat32 = u_xlat34 * u_xlat14.x;
                u_xlat4.x = u_xlat30 * u_xlat32;
                u_xlat14.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                u_xlat34 = fract((-u_xlat14.x));
                u_xlat14.z = u_xlat34 + 0.5;
                u_xlat14.xy = fract(u_xlat14.xy);
                u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
                u_xlat14.xyz = floor(u_xlat14.xyz);
                u_xlat34 = (-u_xlat14.x) + u_xlat14.z;
                u_xlat14.x = u_xlat34 * u_xlat14.y + u_xlat14.x;
                u_xlat24 = (-u_xlat32) * u_xlat30 + 1.0;
                u_xlat5.xyz = (-u_xlat14.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat6.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat14.xxx;
                u_xlatb4.xz = lessThan(u_xlat4.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat7.xyz = u_xlat14.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat30 = u_xlat32 * u_xlat30 + -4.0;
                u_xlat30 = exp2(u_xlat30);
                u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat5.zyy + u_xlat14.xxx;
                u_xlat14.xyz = (u_xlatb4.z) ? u_xlat7.xyz : u_xlat5.xyz;
                u_xlat2.xyz = (u_xlatb4.x) ? u_xlat6.xyz : u_xlat14.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb30 = !!(u_xlat1.x>=u_xlat3.x);
#else
                u_xlatb30 = u_xlat1.x>=u_xlat3.x;
#endif
                if(u_xlatb30){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat4.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat4.xy, u_xlat4.xy);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat4.xy = vec2(u_xlat32) * u_xlat4.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat32);
                    u_xlat4.xy = u_xlat4.xy / vec2(u_xlat30);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat32 = sqrt(u_xlat30);
                    u_xlat14.x = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat4.x);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat32 * u_xlat14.x;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat31) * u_xlat4.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat5.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat3.x * u_xlat3.z, u_xlat3.y * u_xlat3.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat30 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat32 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat30 = max(u_xlat30, u_xlat32);
                    u_xlat30 = log2(u_xlat30);
                    u_xlat30 = u_xlat30 * 0.5;
                    u_xlat30 = max(u_xlat30, 0.0);
                    u_xlat30 = u_xlat30 + 1.0;
                    u_xlat32 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * vec4(u_xlat32);
                    u_xlat1 = u_xlat1 / vec4(u_xlat30);
                    u_xlat30 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat11 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat31 = sqrt(u_xlat30);
                    u_xlat32 = sqrt(u_xlat11);
                    u_xlat30 = inversesqrt(u_xlat30);
                    u_xlat30 = u_xlat30 * abs(u_xlat1.z);
                    u_xlat11 = inversesqrt(u_xlat11);
                    u_xlat1.x = u_xlat11 * abs(u_xlat1.x);
                    u_xlat30 = u_xlat30 * u_xlat1.x;
                    u_xlat30 = (-u_xlat30) * u_xlat30 + 1.0;
                    u_xlat30 = sqrt(u_xlat30);
                    u_xlat1.x = u_xlat31 * u_xlat32;
                    u_xlat11 = u_xlat30 * u_xlat1.x;
                    u_xlat21.xy = vec2(u_xlat3.z * float(3.0), u_xlat3.w * float(3.0));
                    u_xlat32 = fract((-u_xlat21.x));
                    u_xlat32 = u_xlat32 + 0.5;
                    u_xlat32 = floor(u_xlat32);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat32 = (-u_xlat21.x) + u_xlat32;
                    u_xlat21.x = u_xlat32 * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat1.x) * u_xlat30 + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat30 = u_xlat1.x * u_xlat30 + -4.0;
                    u_xlat30 = exp2(u_xlat30);
                    u_xlat30 = u_xlat30 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
                    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb30 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb30){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy, -1.0).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_8.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_8.xxx;
    u_xlat30 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat30 = vs_TEXCOORD5.w * u_xlat30 + _BackDiffuseStrength;
    u_xlat16_9.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat30) * u_xlat16_9.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb30) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat5 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb15 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb15)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat5.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat5.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat5.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat5.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
float u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat6 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat6<0.0);
#else
    u_xlatb0 = u_xlat6<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00784313772;
    u_xlat0 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat0 = vs_TEXCOORD5.w * u_xlat0 + _BackDiffuseStrength;
    SV_Target1.xyz = vec3(u_xlat0) * u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat2.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat2.z;
    SV_Target2.xy = u_xlat2.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat5 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb15 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb15)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_14;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat5.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat5.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat5.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat5.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat5.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat5.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat5.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_4.x = dot(hlslcc_mtx4x4unity_MatrixInvV[2].xz, hlslcc_mtx4x4unity_MatrixInvV[2].xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xy = u_xlat16_4.xx * hlslcc_mtx4x4unity_MatrixInvV[2].xz;
    u_xlat16_14.x = dot(_WorldSpaceLightPos0.xz, _WorldSpaceLightPos0.xz);
    u_xlat16_14.x = inversesqrt(u_xlat16_14.x);
    u_xlat16_14.xy = u_xlat16_14.xx * _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_14.xy);
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    vs_TEXCOORD5.w = u_xlat16_4.x;
    vs_TEXCOORD5.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	float _ForwardDiffuseStrength;
uniform 	float _BackDiffuseStrength;
uniform 	float _SpecularReflectivity;
uniform 	float _Gloss;
uniform 	mediump vec4 _SpecularReflectivityColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
float u_xlat12;
vec2 u_xlat17;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0);
    u_xlat24 = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<0.0);
#else
    u_xlatb24 = u_xlat24<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_1.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat17.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat24 = dot(u_xlat17.xy, u_xlat17.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat24 = max(u_xlat24, u_xlat1.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat1.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat24);
#else
        u_xlatb1.x = 256.0<u_xlat24;
#endif
        u_xlatb9.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat2 = (u_xlatb9.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb9.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
        u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1.zw = vs_TEXCOORD0.xy;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat3 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                u_xlat4.xy = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat24 = dot(u_xlat4.xy, u_xlat4.xy);
                u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat24 = max(u_xlat24, u_xlat26);
                u_xlat24 = log2(u_xlat24);
                u_xlat24 = u_xlat24 * 0.5;
                u_xlat24 = max(u_xlat24, 0.0);
                u_xlat24 = u_xlat24 + 1.0;
                u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat4.xy = vec2(u_xlat26) * u_xlat4.xy;
                u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                u_xlat4.xy = u_xlat4.xy / vec2(u_xlat24);
                u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                u_xlat24 = dot(abs(u_xlat4.xy), abs(u_xlat4.xy));
                u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat11.x = sqrt(u_xlat24);
                u_xlat12 = sqrt(u_xlat26);
                u_xlat24 = inversesqrt(u_xlat24);
                u_xlat24 = u_xlat24 * abs(u_xlat4.x);
                u_xlat26 = inversesqrt(u_xlat26);
                u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                u_xlat24 = u_xlat24 * u_xlat26;
                u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                u_xlat24 = sqrt(u_xlat24);
                u_xlat26 = u_xlat11.x * u_xlat12;
                u_xlat3.x = u_xlat24 * u_xlat26;
                u_xlat11.x = fract((-u_xlat3.z));
                u_xlat11.x = u_xlat11.x + 0.5;
                u_xlat19.xy = fract(u_xlat3.zw);
                u_xlat11.yz = u_xlat19.xy + vec2(0.5, 0.5);
                u_xlat11.xyz = floor(u_xlat11.xyz);
                u_xlat11.x = (-u_xlat11.y) + u_xlat11.x;
                u_xlat11.x = u_xlat11.x * u_xlat11.z + u_xlat11.y;
                u_xlat19.x = (-u_xlat26) * u_xlat24 + 1.0;
                u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = u_xlat19.xxx * u_xlat4.xyz + u_xlat11.xxx;
                u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                u_xlat24 = exp2(u_xlat24);
                u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=4096.0);
#else
                u_xlatb24 = u_xlat1.x>=4096.0;
#endif
                if(u_xlatb24){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat17.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat26 = fract((-u_xlat17.x));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat17.xy);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1 = vs_TEXCOORD0.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat24 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat26 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat26) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat26);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat24);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat9 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat26 = sqrt(u_xlat24);
                    u_xlat11.x = sqrt(u_xlat9);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat1.x = u_xlat9 * abs(u_xlat1.x);
                    u_xlat24 = u_xlat24 * u_xlat1.x;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat1.x = u_xlat26 * u_xlat11.x;
                    u_xlat9 = u_xlat24 * u_xlat1.x;
                    u_xlat26 = fract((-u_xlat1.z));
                    u_xlat26 = u_xlat26 + 0.5;
                    u_xlat26 = floor(u_xlat26);
                    u_xlat17.xy = fract(u_xlat1.zw);
                    u_xlat17.xy = u_xlat17.xy + vec2(0.5, 0.5);
                    u_xlat17.xy = floor(u_xlat17.xy);
                    u_xlat26 = (-u_xlat17.x) + u_xlat26;
                    u_xlat17.x = u_xlat26 * u_xlat17.y + u_xlat17.x;
                    u_xlat25 = (-u_xlat1.x) * u_xlat24 + 1.0;
                    u_xlat3.xyz = (-u_xlat17.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat17.xxx;
                    u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat17.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat1.x * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat17.xxx;
                    u_xlat1.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat24 = (-_BackDiffuseStrength) + _ForwardDiffuseStrength;
    u_xlat24 = vs_TEXCOORD5.w * u_xlat24 + _BackDiffuseStrength;
    u_xlat16_7.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.xyz = vec3(u_xlat24) * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(vec3(_Gloss, _Gloss, _Gloss)) * _SpecularReflectivityColor.xyz;
    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb24 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb24) ? 0.0 : u_xlat0.z;
    SV_Target0.w = 0.00784313772;
    SV_Target1.w = 0.0;
    SV_Target2.xy = u_xlat0.xy;
    SV_Target2.w = _SpecularReflectivity;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
}
}
 Pass {
  Name "TREEBILLBOARDDEPTH"
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "DepthOnly" }
  GpuProgramID 187418
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_3.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_3.xy + _treeLOD2UVSscaleAndOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
flat out highp uint vs_SV_InstanceID0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
int u_xlati5;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb10 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb10)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_4.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
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
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_TEXCOORD1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat4.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat4.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat4.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat4.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat4.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat4.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat4.zxy + (-u_xlat2.xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat4.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz + in_TEXCOORD1.xyz;
    u_xlat1 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _treeLOD2UVSscaleAndOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_3.xy = _treeLOD2UVSscaleAndOffset.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_3.xy + _treeLOD2UVSscaleAndOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct TreePropsArray_Type {
	vec4 _treeLOD2UVSscaleAndOffset;
};
layout(std140) uniform UnityInstancing_TreeProps {
	TreePropsArray_Type TreePropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
flat out highp uint vs_SV_InstanceID0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
int u_xlati5;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati0 << 3;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat10 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.999000013<abs(u_xlat1.y));
#else
    u_xlatb10 = 0.999000013<abs(u_xlat1.y);
#endif
    u_xlat2.xyz = (bool(u_xlatb10)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.yyy;
    u_xlat2.xyz = u_xlat2.xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_4.xy = vec2(1.0, 1.0) + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat16_4.xy + TreePropsArray[u_xlati0]._treeLOD2UVSscaleAndOffset.zw;
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
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.w = u_xlat0.y * _VerticalBillBoarding;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.999000013<abs(u_xlat0.y));
#else
    u_xlatb12 = 0.999000013<abs(u_xlat0.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_TEXCOORD1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _VerticalBillBoarding;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat4.xyz = _WorldSpaceCameraPos.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = u_xlat4.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.w = u_xlat1.y * _VerticalBillBoarding;
    u_xlat4.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xwz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.999000013<abs(u_xlat4.y));
#else
    u_xlatb1 = 0.999000013<abs(u_xlat4.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.0, 1.0);
    u_xlat2.xyz = u_xlat4.yzx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.zxy * u_xlat4.zxy + (-u_xlat2.xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat4.zxy * u_xlat1.yzx;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz + in_TEXCOORD1.xyz;
    u_xlat1 = u_xlat4.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat4.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat4.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
Keywords { "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "BILLBOARD_COMBINE_ON" }
""
}
}
}
}
Fallback "Legacy Shaders/Transparent/Cutout/VertexLit"
}