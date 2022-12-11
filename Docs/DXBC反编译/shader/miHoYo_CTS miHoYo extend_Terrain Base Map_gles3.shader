//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CTS miHoYo extend/Terrain Base Map" {
Properties {
__dirty ("", Float) = 1
_Terrain_Smoothness ("Terrain_Smoothness", Range(0, 2)) = 1
_Terrain_Specular ("Terrain_Specular", Range(0, 3)) = 1
_MainTex ("BaseMap (RGB)", 2D) = "white" { }
_Color ("Main Color", Color) = (1,1,1,1)
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 16281
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_26 = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_26 = u_xlat0.x * u_xlat16_26;
    u_xlat16_0.x = u_xlat16_26 * 0.959999979;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_26 = (-u_xlat10_3.w) * _Terrain_Smoothness + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = (-u_xlat16_8) * u_xlat16_8 + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.0399999991;
    u_xlat4.x = vs_TEXCOORD1.z;
    u_xlat4.y = vs_TEXCOORD2.z;
    u_xlat4.z = vs_TEXCOORD3.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat16 * u_xlat16_8 + (-u_xlat16);
    u_xlat16 = u_xlat24 * u_xlat16 + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = max(u_xlat16, 9.99999997e-07);
    u_xlat8 = u_xlat16_8 / u_xlat16;
    u_xlat8 = u_xlat8 * 0.318309873;
    u_xlat8 = min(u_xlat8, 64.0);
    u_xlat16 = u_xlat16_0.x * u_xlat8;
    u_xlat0.x = u_xlat8 * u_xlat16_0.x + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_26 = vs_TEXCOORD2.z * vs_TEXCOORD2.z;
    u_xlat16_26 = vs_TEXCOORD1.z * vs_TEXCOORD1.z + (-u_xlat16_26);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = unity_SHC.xyz * vec3(u_xlat16_26) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_26 = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
}
}
 Pass {
  Name "HYBRIDDEFERRED"
  LOD 100
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "RenderType" = "Opaque" }
  GpuProgramID 115852
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _TerrainLODLevel;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _SSAO_Intensity;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Texture_1_Tiling;
uniform 	mediump float _Texture_2_Tiling;
uniform 	mediump float _Texture_3_Tiling;
uniform 	mediump float _Texture_4_Tiling;
uniform 	mediump float _Texture_5_Tiling;
uniform 	mediump float _Texture_6_Tiling;
uniform 	mediump float _Texture_7_Tiling;
uniform 	mediump float _Texture_8_Tiling;
uniform 	vec4 _Texture_1_Albedo_TexelSize;
uniform 	vec4 _Texture_2_Albedo_TexelSize;
uniform 	vec4 _Texture_3_Albedo_TexelSize;
uniform 	vec4 _Texture_4_Albedo_TexelSize;
uniform 	vec4 _Texture_5_Albedo_TexelSize;
uniform 	vec4 _Texture_6_Albedo_TexelSize;
uniform 	vec4 _Texture_7_Albedo_TexelSize;
uniform 	vec4 _Texture_8_Albedo_TexelSize;
uniform 	vec4 _Texture_1_Normal_TexelSize;
uniform 	vec4 _Texture_2_Normal_TexelSize;
uniform 	vec4 _Texture_3_Normal_TexelSize;
uniform 	vec4 _Texture_4_Normal_TexelSize;
uniform 	vec4 _Texture_5_Normal_TexelSize;
uniform 	vec4 _Texture_6_Normal_TexelSize;
uniform 	vec4 _Texture_7_Normal_TexelSize;
uniform 	vec4 _Texture_8_Normal_TexelSize;
uniform lowp sampler2D _Texture_Splat_1;
uniform lowp sampler2D _Texture_Splat_2;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
ivec3 u_xlati3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec2 u_xlatb6;
vec4 u_xlat7;
vec4 u_xlat8;
vec3 u_xlat9;
bvec2 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
bvec2 u_xlatb18;
vec2 u_xlat19;
vec2 u_xlat21;
bvec2 u_xlatb21;
vec2 u_xlat23;
vec2 u_xlat24;
vec2 u_xlat25;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat30;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.z<1.5);
#else
    u_xlatb0.x = vs_TEXCOORD0.z<1.5;
#endif
    u_xlatb9.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
    u_xlatb9.x = u_xlatb9.y || u_xlatb9.x;
    u_xlat1.xy = _MainTex_TexelSize.zw;
    u_xlat1.zw = vs_TEXCOORD0.xy;
    u_xlat1 = (u_xlatb9.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat1 = (u_xlatb0.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat2.x = float(4096.0);
    u_xlat2.y = float(4096.0);
    u_xlat2.zw = vs_TEXCOORD0.xy;
    u_xlat2 = (u_xlatb0.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
    if(!u_xlatb0.x){
        u_xlat0 = texture(_Texture_Splat_1, vs_TEXCOORD0.xy);
        u_xlatb0 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat0);
        u_xlat3.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat1.xyxx, u_xlat3.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat4.xy = _Texture_1_Albedo_TexelSize.zw;
        u_xlat4.zw = vs_TEXCOORD2.xz;
        u_xlat4 = (u_xlati3.x != 0) ? u_xlat4 : u_xlat1;
        u_xlat21.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat2.yyyy, u_xlat21.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat5.xy = _Texture_1_Normal_TexelSize.zw;
        u_xlat5.zw = vs_TEXCOORD2.xz;
        u_xlat5 = (u_xlati3.z != 0) ? u_xlat5 : u_xlat2;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat4 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
        u_xlat5 = (u_xlatb0.x) ? u_xlat5 : u_xlat2;
        u_xlat3.xy = (u_xlatb0.x) ? u_xlat3.xy : vec2(1.0, 1.0);
        u_xlat21.xy = u_xlat3.xx * u_xlat4.xy;
        u_xlat6.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat6.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat6.xy = _Texture_2_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
        u_xlat7.x = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.x;
        u_xlat21.xy = u_xlat3.yy * u_xlat5.xy;
        u_xlat25.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat25.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat8.xy = _Texture_2_Normal_TexelSize.zw;
        u_xlat8.zw = vs_TEXCOORD2.xz;
        u_xlat8 = (u_xlatb0.x) ? u_xlat8 : u_xlat5;
        u_xlat7.y = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.y;
        u_xlat4 = (u_xlatb0.y) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.y) ? u_xlat8 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.y) ? u_xlat7.xy : u_xlat3.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat6.xy = _Texture_3_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlati3.x != 0) ? u_xlat6 : u_xlat4;
        u_xlat21.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat7.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat7.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat7.xy = _Texture_3_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlati3.z != 0) ? u_xlat7 : u_xlat5;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_3_Tiling) : u_xlat0.x;
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_3_Tiling) : u_xlat0.y;
        u_xlat4 = (u_xlatb0.z) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.z) ? u_xlat7 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.z) ? u_xlat3.xy : u_xlat0.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(_Texture_4_Tiling * _Texture_4_Albedo_TexelSize.z, _Texture_4_Tiling * _Texture_4_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlatb18.x = u_xlatb3.y || u_xlatb3.x;
        u_xlat3.xy = _Texture_4_Albedo_TexelSize.zw;
        u_xlat3.zw = vs_TEXCOORD2.xz;
        u_xlat3 = (u_xlatb18.x) ? u_xlat3 : u_xlat4;
        u_xlat6.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat24.xy = vec2(_Texture_4_Tiling * _Texture_4_Normal_TexelSize.z, _Texture_4_Tiling * _Texture_4_Normal_TexelSize.w);
        u_xlatb6.xy = lessThan(u_xlat6.xyxx, u_xlat24.xyxx).xy;
        u_xlatb6.x = u_xlatb6.y || u_xlatb6.x;
        u_xlat7.xy = _Texture_4_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlatb6.x) ? u_xlat7 : u_xlat5;
        u_xlat1 = (u_xlatb0.w) ? u_xlat3 : u_xlat4;
        u_xlat2 = (u_xlatb0.w) ? u_xlat7 : u_xlat5;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3.x = !!(2.5<vs_TEXCOORD0.z);
#else
        u_xlatb3.x = 2.5<vs_TEXCOORD0.z;
#endif
        if(u_xlatb3.x){
            u_xlat3.x = (u_xlatb18.x) ? _Texture_4_Tiling : u_xlat0.x;
            u_xlat3.y = (u_xlatb6.x) ? _Texture_4_Tiling : u_xlat0.y;
            u_xlat0.xy = (u_xlatb0.w) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat3 = texture(_Texture_Splat_2, vs_TEXCOORD0.xy);
            u_xlatb3 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat3);
            u_xlat18.xy = u_xlat0.xx * u_xlat1.xy;
            u_xlat4.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat4.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat4.xy = _Texture_5_Albedo_TexelSize.zw;
            u_xlat4.zw = vs_TEXCOORD2.xz;
            u_xlat4 = (u_xlatb18.x) ? u_xlat4 : u_xlat1;
            u_xlat5.x = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat2.xy;
            u_xlat23.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat23.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_5_Normal_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat2;
            u_xlat5.y = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.x) ? u_xlat4 : u_xlat1;
            u_xlat6 = (u_xlatb3.x) ? u_xlat6 : u_xlat2;
            u_xlat0.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat5.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat5.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat5.xy = _Texture_6_Albedo_TexelSize.zw;
            u_xlat5.zw = vs_TEXCOORD2.xz;
            u_xlat5 = (u_xlatb18.x) ? u_xlat5 : u_xlat4;
            u_xlat7.x = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat6.xy;
            u_xlat25.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat25.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat8.xy = _Texture_6_Normal_TexelSize.zw;
            u_xlat8.zw = vs_TEXCOORD2.xz;
            u_xlat8 = (u_xlatb18.x) ? u_xlat8 : u_xlat6;
            u_xlat7.y = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.y) ? u_xlat5 : u_xlat4;
            u_xlat5 = (u_xlatb3.y) ? u_xlat8 : u_xlat6;
            u_xlat0.xy = (u_xlatb3.y) ? u_xlat7.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat3.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_7_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat4;
            u_xlat3.x = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat7.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat7.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat7.xy = _Texture_7_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat7 = (u_xlatb18.x) ? u_xlat7 : u_xlat5;
            u_xlat3.y = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.z) ? u_xlat6 : u_xlat4;
            u_xlat5 = (u_xlatb3.z) ? u_xlat7 : u_xlat5;
            u_xlat0.xy = (u_xlatb3.z) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat0.xz = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(_Texture_8_Tiling * _Texture_8_Albedo_TexelSize.z, _Texture_8_Tiling * _Texture_8_Albedo_TexelSize.w);
            u_xlatb0.xz = lessThan(u_xlat0.xxzx, u_xlat3.xxyx).xz;
            u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
            u_xlat6.xy = _Texture_8_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
            u_xlat0.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat18.xy = vec2(_Texture_8_Tiling * _Texture_8_Normal_TexelSize.z, _Texture_8_Tiling * _Texture_8_Normal_TexelSize.w);
            u_xlatb0.xy = lessThan(u_xlat0.xyxx, u_xlat18.xyxx).xy;
            u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
            u_xlat7.xy = _Texture_8_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat0 = (u_xlatb0.x) ? u_xlat7 : u_xlat5;
            u_xlat1 = (u_xlatb3.w) ? u_xlat6 : u_xlat4;
            u_xlat2 = (u_xlatb3.w) ? u_xlat0 : u_xlat5;
        //ENDIF
        }
    } else {
        u_xlat2 = u_xlat2.yyzw;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlatb0 = lessThan(vec4(4.9000001, 3.9000001, 2.9000001, 1.89999998), vec4(vec4(_TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel)));
        u_xlatb3.xy = lessThan(vec4(0.899999976, -0.100000001, 0.0, 0.0), vec4(vec4(_TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel))).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(0.5, 0.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb0.w) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb0.z) ? vec4(0.5, 0.5, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb0.y) ? vec4(0.0, 0.5, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb0.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat3;
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat9.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb0.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat0.zw = dFdx(u_xlat0.xy);
            u_xlat0.xy = dFdy(u_xlat0.xy);
            u_xlat3.x = dot(u_xlat0.zw, u_xlat0.zw);
            u_xlat12.x = dot(u_xlat0.xy, u_xlat0.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat0 = u_xlat0 * u_xlat12.xxxx;
            u_xlat0 = u_xlat0 / u_xlat3.xxxx;
            u_xlat9.z = dot(abs(u_xlat0.zw), abs(u_xlat0.zw));
            u_xlat9.x = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
            u_xlat3.xy = sqrt(u_xlat9.zx);
            u_xlat9.z = inversesqrt(u_xlat9.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat0.xz = u_xlat9.xz * abs(u_xlat0.xz);
            u_xlat0.x = u_xlat0.x * u_xlat0.z;
            u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
            u_xlat0.x = sqrt(u_xlat0.x);
            u_xlat9.x = u_xlat3.y * u_xlat3.x;
            u_xlat18.x = u_xlat0.x * u_xlat9.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat27 = fract((-u_xlat3.x));
            u_xlat27 = u_xlat27 + 0.5;
            u_xlat27 = floor(u_xlat27);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat27 = u_xlat27 + (-u_xlat3.x);
            u_xlat27 = u_xlat27 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat9.x) * u_xlat0.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat27)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat27);
            u_xlatb3.xy = lessThan(u_xlat18.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat27) * vec3(0.0, 1.0, 0.0);
            u_xlat0.x = u_xlat9.x * u_xlat0.x + -4.0;
            u_xlat0.x = exp2(u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
            u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
            u_xlat0.xyz = u_xlat0.xxx * u_xlat12.zyy + vec3(u_xlat27);
            u_xlat0.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat0.xyz;
            u_xlat0.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat0.xyz;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb27 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb27 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb27){
                u_xlat3.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat27 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat27 = max(u_xlat27, u_xlat4.x);
                u_xlat27 = log2(u_xlat27);
                u_xlat27 = u_xlat27 * 0.5;
                u_xlat27 = max(u_xlat27, 0.0);
                u_xlat27 = u_xlat27 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat27);
                u_xlat27 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat27);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat27 = inversesqrt(u_xlat27);
                u_xlat27 = u_xlat27 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat27 = u_xlat27 * u_xlat3.x;
                u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                u_xlat27 = sqrt(u_xlat27);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat27 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat27 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat27 = u_xlat3.x * u_xlat27 + -4.0;
                u_xlat27 = exp2(u_xlat27);
                u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat0.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb27 = !!(u_xlat1.x>=u_xlat2.x);
#else
                u_xlatb27 = u_xlat1.x>=u_xlat2.x;
#endif
                if(u_xlatb27){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat21.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat27);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat27);
                    u_xlat21.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat3.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat21.x * u_xlat12.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat2.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat2.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat2.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat28 = sqrt(u_xlat27);
                    u_xlat2.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat1.z);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat28 * u_xlat2.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat2.x = fract((-u_xlat19.x));
                    u_xlat2.x = u_xlat2.x + 0.5;
                    u_xlat2.x = floor(u_xlat2.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat2.x = (-u_xlat19.x) + u_xlat2.x;
                    u_xlat19.x = u_xlat2.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat2.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat4.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat4.xyz : u_xlat2.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat3.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        u_xlat0 = vs_TEXCOORD0.zzzz * vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb27 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb27) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _SSAO_Intensity;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Texture_1_Tiling;
uniform 	mediump float _Texture_2_Tiling;
uniform 	mediump float _Texture_3_Tiling;
uniform 	mediump float _Texture_4_Tiling;
uniform 	mediump float _Texture_5_Tiling;
uniform 	mediump float _Texture_6_Tiling;
uniform 	mediump float _Texture_7_Tiling;
uniform 	mediump float _Texture_8_Tiling;
uniform 	vec4 _Texture_1_Albedo_TexelSize;
uniform 	vec4 _Texture_2_Albedo_TexelSize;
uniform 	vec4 _Texture_3_Albedo_TexelSize;
uniform 	vec4 _Texture_4_Albedo_TexelSize;
uniform 	vec4 _Texture_5_Albedo_TexelSize;
uniform 	vec4 _Texture_6_Albedo_TexelSize;
uniform 	vec4 _Texture_7_Albedo_TexelSize;
uniform 	vec4 _Texture_8_Albedo_TexelSize;
uniform 	vec4 _Texture_1_Normal_TexelSize;
uniform 	vec4 _Texture_2_Normal_TexelSize;
uniform 	vec4 _Texture_3_Normal_TexelSize;
uniform 	vec4 _Texture_4_Normal_TexelSize;
uniform 	vec4 _Texture_5_Normal_TexelSize;
uniform 	vec4 _Texture_6_Normal_TexelSize;
uniform 	vec4 _Texture_7_Normal_TexelSize;
uniform 	vec4 _Texture_8_Normal_TexelSize;
struct DebugView_PropsArray_Type {
	float _TerrainLODLevel;
};
layout(std140) uniform UnityInstancing_DebugView_Props {
	DebugView_PropsArray_Type DebugView_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Texture_Splat_1;
uniform lowp sampler2D _Texture_Splat_2;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
ivec3 u_xlati3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec2 u_xlatb6;
vec4 u_xlat7;
vec4 u_xlat8;
vec3 u_xlat9;
bvec2 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
bvec2 u_xlatb18;
vec2 u_xlat19;
vec2 u_xlat21;
bvec2 u_xlatb21;
vec2 u_xlat23;
vec2 u_xlat24;
vec2 u_xlat25;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat30;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.z<1.5);
#else
    u_xlatb0.x = vs_TEXCOORD0.z<1.5;
#endif
    u_xlatb9.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
    u_xlatb9.x = u_xlatb9.y || u_xlatb9.x;
    u_xlat1.xy = _MainTex_TexelSize.zw;
    u_xlat1.zw = vs_TEXCOORD0.xy;
    u_xlat1 = (u_xlatb9.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat1 = (u_xlatb0.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat2.x = float(4096.0);
    u_xlat2.y = float(4096.0);
    u_xlat2.zw = vs_TEXCOORD0.xy;
    u_xlat2 = (u_xlatb0.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
    if(!u_xlatb0.x){
        u_xlat0 = texture(_Texture_Splat_1, vs_TEXCOORD0.xy);
        u_xlatb0 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat0);
        u_xlat3.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat1.xyxx, u_xlat3.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat4.xy = _Texture_1_Albedo_TexelSize.zw;
        u_xlat4.zw = vs_TEXCOORD2.xz;
        u_xlat4 = (u_xlati3.x != 0) ? u_xlat4 : u_xlat1;
        u_xlat21.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat2.yyyy, u_xlat21.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat5.xy = _Texture_1_Normal_TexelSize.zw;
        u_xlat5.zw = vs_TEXCOORD2.xz;
        u_xlat5 = (u_xlati3.z != 0) ? u_xlat5 : u_xlat2;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat4 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
        u_xlat5 = (u_xlatb0.x) ? u_xlat5 : u_xlat2;
        u_xlat3.xy = (u_xlatb0.x) ? u_xlat3.xy : vec2(1.0, 1.0);
        u_xlat21.xy = u_xlat3.xx * u_xlat4.xy;
        u_xlat6.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat6.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat6.xy = _Texture_2_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
        u_xlat7.x = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.x;
        u_xlat21.xy = u_xlat3.yy * u_xlat5.xy;
        u_xlat25.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat25.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat8.xy = _Texture_2_Normal_TexelSize.zw;
        u_xlat8.zw = vs_TEXCOORD2.xz;
        u_xlat8 = (u_xlatb0.x) ? u_xlat8 : u_xlat5;
        u_xlat7.y = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.y;
        u_xlat4 = (u_xlatb0.y) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.y) ? u_xlat8 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.y) ? u_xlat7.xy : u_xlat3.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat6.xy = _Texture_3_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlati3.x != 0) ? u_xlat6 : u_xlat4;
        u_xlat21.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat7.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat7.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat7.xy = _Texture_3_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlati3.z != 0) ? u_xlat7 : u_xlat5;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_3_Tiling) : u_xlat0.x;
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_3_Tiling) : u_xlat0.y;
        u_xlat4 = (u_xlatb0.z) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.z) ? u_xlat7 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.z) ? u_xlat3.xy : u_xlat0.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(_Texture_4_Tiling * _Texture_4_Albedo_TexelSize.z, _Texture_4_Tiling * _Texture_4_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlatb18.x = u_xlatb3.y || u_xlatb3.x;
        u_xlat3.xy = _Texture_4_Albedo_TexelSize.zw;
        u_xlat3.zw = vs_TEXCOORD2.xz;
        u_xlat3 = (u_xlatb18.x) ? u_xlat3 : u_xlat4;
        u_xlat6.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat24.xy = vec2(_Texture_4_Tiling * _Texture_4_Normal_TexelSize.z, _Texture_4_Tiling * _Texture_4_Normal_TexelSize.w);
        u_xlatb6.xy = lessThan(u_xlat6.xyxx, u_xlat24.xyxx).xy;
        u_xlatb6.x = u_xlatb6.y || u_xlatb6.x;
        u_xlat7.xy = _Texture_4_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlatb6.x) ? u_xlat7 : u_xlat5;
        u_xlat1 = (u_xlatb0.w) ? u_xlat3 : u_xlat4;
        u_xlat2 = (u_xlatb0.w) ? u_xlat7 : u_xlat5;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3.x = !!(2.5<vs_TEXCOORD0.z);
#else
        u_xlatb3.x = 2.5<vs_TEXCOORD0.z;
#endif
        if(u_xlatb3.x){
            u_xlat3.x = (u_xlatb18.x) ? _Texture_4_Tiling : u_xlat0.x;
            u_xlat3.y = (u_xlatb6.x) ? _Texture_4_Tiling : u_xlat0.y;
            u_xlat0.xy = (u_xlatb0.w) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat3 = texture(_Texture_Splat_2, vs_TEXCOORD0.xy);
            u_xlatb3 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat3);
            u_xlat18.xy = u_xlat0.xx * u_xlat1.xy;
            u_xlat4.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat4.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat4.xy = _Texture_5_Albedo_TexelSize.zw;
            u_xlat4.zw = vs_TEXCOORD2.xz;
            u_xlat4 = (u_xlatb18.x) ? u_xlat4 : u_xlat1;
            u_xlat5.x = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat2.xy;
            u_xlat23.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat23.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_5_Normal_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat2;
            u_xlat5.y = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.x) ? u_xlat4 : u_xlat1;
            u_xlat6 = (u_xlatb3.x) ? u_xlat6 : u_xlat2;
            u_xlat0.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat5.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat5.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat5.xy = _Texture_6_Albedo_TexelSize.zw;
            u_xlat5.zw = vs_TEXCOORD2.xz;
            u_xlat5 = (u_xlatb18.x) ? u_xlat5 : u_xlat4;
            u_xlat7.x = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat6.xy;
            u_xlat25.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat25.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat8.xy = _Texture_6_Normal_TexelSize.zw;
            u_xlat8.zw = vs_TEXCOORD2.xz;
            u_xlat8 = (u_xlatb18.x) ? u_xlat8 : u_xlat6;
            u_xlat7.y = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.y) ? u_xlat5 : u_xlat4;
            u_xlat5 = (u_xlatb3.y) ? u_xlat8 : u_xlat6;
            u_xlat0.xy = (u_xlatb3.y) ? u_xlat7.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat3.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_7_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat4;
            u_xlat3.x = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat7.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat7.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat7.xy = _Texture_7_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat7 = (u_xlatb18.x) ? u_xlat7 : u_xlat5;
            u_xlat3.y = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.z) ? u_xlat6 : u_xlat4;
            u_xlat5 = (u_xlatb3.z) ? u_xlat7 : u_xlat5;
            u_xlat0.xy = (u_xlatb3.z) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat0.xz = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(_Texture_8_Tiling * _Texture_8_Albedo_TexelSize.z, _Texture_8_Tiling * _Texture_8_Albedo_TexelSize.w);
            u_xlatb0.xz = lessThan(u_xlat0.xxzx, u_xlat3.xxyx).xz;
            u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
            u_xlat6.xy = _Texture_8_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
            u_xlat0.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat18.xy = vec2(_Texture_8_Tiling * _Texture_8_Normal_TexelSize.z, _Texture_8_Tiling * _Texture_8_Normal_TexelSize.w);
            u_xlatb0.xy = lessThan(u_xlat0.xyxx, u_xlat18.xyxx).xy;
            u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
            u_xlat7.xy = _Texture_8_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat0 = (u_xlatb0.x) ? u_xlat7 : u_xlat5;
            u_xlat1 = (u_xlatb3.w) ? u_xlat6 : u_xlat4;
            u_xlat2 = (u_xlatb3.w) ? u_xlat0 : u_xlat5;
        //ENDIF
        }
    } else {
        u_xlat2 = u_xlat2.yyzw;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
        u_xlatb3 = lessThan(vec4(4.9000001, 3.9000001, 2.9000001, 1.89999998), vec4(DebugView_PropsArray[u_xlati0]._TerrainLODLevel));
        u_xlatb0.xy = lessThan(vec4(0.899999976, -0.100000001, 0.0, 0.0), vec4(DebugView_PropsArray[u_xlati0]._TerrainLODLevel)).xy;
        u_xlat4 = (u_xlatb0.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat0 = (u_xlatb0.x) ? vec4(0.5, 0.0, 0.0, 1.0) : u_xlat4;
        u_xlat0 = (u_xlatb3.w) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (u_xlatb3.z) ? vec4(0.5, 0.5, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (u_xlatb3.y) ? vec4(0.0, 0.5, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat0;
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat9.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb0.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat0.zw = dFdx(u_xlat0.xy);
            u_xlat0.xy = dFdy(u_xlat0.xy);
            u_xlat3.x = dot(u_xlat0.zw, u_xlat0.zw);
            u_xlat12.x = dot(u_xlat0.xy, u_xlat0.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat0 = u_xlat0 * u_xlat12.xxxx;
            u_xlat0 = u_xlat0 / u_xlat3.xxxx;
            u_xlat9.z = dot(abs(u_xlat0.zw), abs(u_xlat0.zw));
            u_xlat9.x = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
            u_xlat3.xy = sqrt(u_xlat9.zx);
            u_xlat9.z = inversesqrt(u_xlat9.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat0.xz = u_xlat9.xz * abs(u_xlat0.xz);
            u_xlat0.x = u_xlat0.x * u_xlat0.z;
            u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
            u_xlat0.x = sqrt(u_xlat0.x);
            u_xlat9.x = u_xlat3.y * u_xlat3.x;
            u_xlat18.x = u_xlat0.x * u_xlat9.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat27 = fract((-u_xlat3.x));
            u_xlat27 = u_xlat27 + 0.5;
            u_xlat27 = floor(u_xlat27);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat27 = u_xlat27 + (-u_xlat3.x);
            u_xlat27 = u_xlat27 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat9.x) * u_xlat0.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat27)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat27);
            u_xlatb3.xy = lessThan(u_xlat18.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat27) * vec3(0.0, 1.0, 0.0);
            u_xlat0.x = u_xlat9.x * u_xlat0.x + -4.0;
            u_xlat0.x = exp2(u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
            u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
            u_xlat0.xyz = u_xlat0.xxx * u_xlat12.zyy + vec3(u_xlat27);
            u_xlat0.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat0.xyz;
            u_xlat0.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat0.xyz;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb27 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb27 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb27){
                u_xlat3.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat27 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat27 = max(u_xlat27, u_xlat4.x);
                u_xlat27 = log2(u_xlat27);
                u_xlat27 = u_xlat27 * 0.5;
                u_xlat27 = max(u_xlat27, 0.0);
                u_xlat27 = u_xlat27 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat27);
                u_xlat27 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat27);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat27 = inversesqrt(u_xlat27);
                u_xlat27 = u_xlat27 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat27 = u_xlat27 * u_xlat3.x;
                u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                u_xlat27 = sqrt(u_xlat27);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat27 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat27 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat27 = u_xlat3.x * u_xlat27 + -4.0;
                u_xlat27 = exp2(u_xlat27);
                u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat0.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb27 = !!(u_xlat1.x>=u_xlat2.x);
#else
                u_xlatb27 = u_xlat1.x>=u_xlat2.x;
#endif
                if(u_xlatb27){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat21.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat27);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat27);
                    u_xlat21.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat3.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat21.x * u_xlat12.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat2.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat2.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat2.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat28 = sqrt(u_xlat27);
                    u_xlat2.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat1.z);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat28 * u_xlat2.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat2.x = fract((-u_xlat19.x));
                    u_xlat2.x = u_xlat2.x + 0.5;
                    u_xlat2.x = floor(u_xlat2.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat2.x = (-u_xlat19.x) + u_xlat2.x;
                    u_xlat19.x = u_xlat2.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat2.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat4.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat4.xyz : u_xlat2.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat3.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        u_xlat0 = vs_TEXCOORD0.zzzz * vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb27 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb27) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _TerrainLODLevel;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _SSAO_Intensity;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Texture_1_Tiling;
uniform 	mediump float _Texture_2_Tiling;
uniform 	mediump float _Texture_3_Tiling;
uniform 	mediump float _Texture_4_Tiling;
uniform 	mediump float _Texture_5_Tiling;
uniform 	mediump float _Texture_6_Tiling;
uniform 	mediump float _Texture_7_Tiling;
uniform 	mediump float _Texture_8_Tiling;
uniform 	vec4 _Texture_1_Albedo_TexelSize;
uniform 	vec4 _Texture_2_Albedo_TexelSize;
uniform 	vec4 _Texture_3_Albedo_TexelSize;
uniform 	vec4 _Texture_4_Albedo_TexelSize;
uniform 	vec4 _Texture_5_Albedo_TexelSize;
uniform 	vec4 _Texture_6_Albedo_TexelSize;
uniform 	vec4 _Texture_7_Albedo_TexelSize;
uniform 	vec4 _Texture_8_Albedo_TexelSize;
uniform 	vec4 _Texture_1_Normal_TexelSize;
uniform 	vec4 _Texture_2_Normal_TexelSize;
uniform 	vec4 _Texture_3_Normal_TexelSize;
uniform 	vec4 _Texture_4_Normal_TexelSize;
uniform 	vec4 _Texture_5_Normal_TexelSize;
uniform 	vec4 _Texture_6_Normal_TexelSize;
uniform 	vec4 _Texture_7_Normal_TexelSize;
uniform 	vec4 _Texture_8_Normal_TexelSize;
uniform lowp sampler2D _Texture_Splat_1;
uniform lowp sampler2D _Texture_Splat_2;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
ivec3 u_xlati3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec2 u_xlatb6;
vec4 u_xlat7;
vec4 u_xlat8;
vec3 u_xlat9;
bvec2 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
bvec2 u_xlatb18;
vec2 u_xlat19;
vec2 u_xlat21;
bvec2 u_xlatb21;
vec2 u_xlat23;
vec2 u_xlat24;
vec2 u_xlat25;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat30;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.z<1.5);
#else
    u_xlatb0.x = vs_TEXCOORD0.z<1.5;
#endif
    u_xlatb9.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
    u_xlatb9.x = u_xlatb9.y || u_xlatb9.x;
    u_xlat1.xy = _MainTex_TexelSize.zw;
    u_xlat1.zw = vs_TEXCOORD0.xy;
    u_xlat1 = (u_xlatb9.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat1 = (u_xlatb0.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat2.x = float(4096.0);
    u_xlat2.y = float(4096.0);
    u_xlat2.zw = vs_TEXCOORD0.xy;
    u_xlat2 = (u_xlatb0.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
    if(!u_xlatb0.x){
        u_xlat0 = texture(_Texture_Splat_1, vs_TEXCOORD0.xy);
        u_xlatb0 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat0);
        u_xlat3.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat1.xyxx, u_xlat3.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat4.xy = _Texture_1_Albedo_TexelSize.zw;
        u_xlat4.zw = vs_TEXCOORD2.xz;
        u_xlat4 = (u_xlati3.x != 0) ? u_xlat4 : u_xlat1;
        u_xlat21.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat2.yyyy, u_xlat21.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat5.xy = _Texture_1_Normal_TexelSize.zw;
        u_xlat5.zw = vs_TEXCOORD2.xz;
        u_xlat5 = (u_xlati3.z != 0) ? u_xlat5 : u_xlat2;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat4 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
        u_xlat5 = (u_xlatb0.x) ? u_xlat5 : u_xlat2;
        u_xlat3.xy = (u_xlatb0.x) ? u_xlat3.xy : vec2(1.0, 1.0);
        u_xlat21.xy = u_xlat3.xx * u_xlat4.xy;
        u_xlat6.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat6.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat6.xy = _Texture_2_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
        u_xlat7.x = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.x;
        u_xlat21.xy = u_xlat3.yy * u_xlat5.xy;
        u_xlat25.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat25.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat8.xy = _Texture_2_Normal_TexelSize.zw;
        u_xlat8.zw = vs_TEXCOORD2.xz;
        u_xlat8 = (u_xlatb0.x) ? u_xlat8 : u_xlat5;
        u_xlat7.y = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.y;
        u_xlat4 = (u_xlatb0.y) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.y) ? u_xlat8 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.y) ? u_xlat7.xy : u_xlat3.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat6.xy = _Texture_3_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlati3.x != 0) ? u_xlat6 : u_xlat4;
        u_xlat21.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat7.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat7.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat7.xy = _Texture_3_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlati3.z != 0) ? u_xlat7 : u_xlat5;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_3_Tiling) : u_xlat0.x;
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_3_Tiling) : u_xlat0.y;
        u_xlat4 = (u_xlatb0.z) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.z) ? u_xlat7 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.z) ? u_xlat3.xy : u_xlat0.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(_Texture_4_Tiling * _Texture_4_Albedo_TexelSize.z, _Texture_4_Tiling * _Texture_4_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlatb18.x = u_xlatb3.y || u_xlatb3.x;
        u_xlat3.xy = _Texture_4_Albedo_TexelSize.zw;
        u_xlat3.zw = vs_TEXCOORD2.xz;
        u_xlat3 = (u_xlatb18.x) ? u_xlat3 : u_xlat4;
        u_xlat6.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat24.xy = vec2(_Texture_4_Tiling * _Texture_4_Normal_TexelSize.z, _Texture_4_Tiling * _Texture_4_Normal_TexelSize.w);
        u_xlatb6.xy = lessThan(u_xlat6.xyxx, u_xlat24.xyxx).xy;
        u_xlatb6.x = u_xlatb6.y || u_xlatb6.x;
        u_xlat7.xy = _Texture_4_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlatb6.x) ? u_xlat7 : u_xlat5;
        u_xlat1 = (u_xlatb0.w) ? u_xlat3 : u_xlat4;
        u_xlat2 = (u_xlatb0.w) ? u_xlat7 : u_xlat5;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3.x = !!(2.5<vs_TEXCOORD0.z);
#else
        u_xlatb3.x = 2.5<vs_TEXCOORD0.z;
#endif
        if(u_xlatb3.x){
            u_xlat3.x = (u_xlatb18.x) ? _Texture_4_Tiling : u_xlat0.x;
            u_xlat3.y = (u_xlatb6.x) ? _Texture_4_Tiling : u_xlat0.y;
            u_xlat0.xy = (u_xlatb0.w) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat3 = texture(_Texture_Splat_2, vs_TEXCOORD0.xy);
            u_xlatb3 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat3);
            u_xlat18.xy = u_xlat0.xx * u_xlat1.xy;
            u_xlat4.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat4.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat4.xy = _Texture_5_Albedo_TexelSize.zw;
            u_xlat4.zw = vs_TEXCOORD2.xz;
            u_xlat4 = (u_xlatb18.x) ? u_xlat4 : u_xlat1;
            u_xlat5.x = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat2.xy;
            u_xlat23.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat23.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_5_Normal_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat2;
            u_xlat5.y = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.x) ? u_xlat4 : u_xlat1;
            u_xlat6 = (u_xlatb3.x) ? u_xlat6 : u_xlat2;
            u_xlat0.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat5.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat5.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat5.xy = _Texture_6_Albedo_TexelSize.zw;
            u_xlat5.zw = vs_TEXCOORD2.xz;
            u_xlat5 = (u_xlatb18.x) ? u_xlat5 : u_xlat4;
            u_xlat7.x = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat6.xy;
            u_xlat25.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat25.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat8.xy = _Texture_6_Normal_TexelSize.zw;
            u_xlat8.zw = vs_TEXCOORD2.xz;
            u_xlat8 = (u_xlatb18.x) ? u_xlat8 : u_xlat6;
            u_xlat7.y = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.y) ? u_xlat5 : u_xlat4;
            u_xlat5 = (u_xlatb3.y) ? u_xlat8 : u_xlat6;
            u_xlat0.xy = (u_xlatb3.y) ? u_xlat7.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat3.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_7_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat4;
            u_xlat3.x = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat7.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat7.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat7.xy = _Texture_7_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat7 = (u_xlatb18.x) ? u_xlat7 : u_xlat5;
            u_xlat3.y = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.z) ? u_xlat6 : u_xlat4;
            u_xlat5 = (u_xlatb3.z) ? u_xlat7 : u_xlat5;
            u_xlat0.xy = (u_xlatb3.z) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat0.xz = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(_Texture_8_Tiling * _Texture_8_Albedo_TexelSize.z, _Texture_8_Tiling * _Texture_8_Albedo_TexelSize.w);
            u_xlatb0.xz = lessThan(u_xlat0.xxzx, u_xlat3.xxyx).xz;
            u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
            u_xlat6.xy = _Texture_8_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
            u_xlat0.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat18.xy = vec2(_Texture_8_Tiling * _Texture_8_Normal_TexelSize.z, _Texture_8_Tiling * _Texture_8_Normal_TexelSize.w);
            u_xlatb0.xy = lessThan(u_xlat0.xyxx, u_xlat18.xyxx).xy;
            u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
            u_xlat7.xy = _Texture_8_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat0 = (u_xlatb0.x) ? u_xlat7 : u_xlat5;
            u_xlat1 = (u_xlatb3.w) ? u_xlat6 : u_xlat4;
            u_xlat2 = (u_xlatb3.w) ? u_xlat0 : u_xlat5;
        //ENDIF
        }
    } else {
        u_xlat2 = u_xlat2.yyzw;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlatb0 = lessThan(vec4(4.9000001, 3.9000001, 2.9000001, 1.89999998), vec4(vec4(_TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel)));
        u_xlatb3.xy = lessThan(vec4(0.899999976, -0.100000001, 0.0, 0.0), vec4(vec4(_TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel, _TerrainLODLevel))).xy;
        u_xlat4 = (u_xlatb3.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat3 = (u_xlatb3.x) ? vec4(0.5, 0.0, 0.0, 1.0) : u_xlat4;
        u_xlat3 = (u_xlatb0.w) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb0.z) ? vec4(0.5, 0.5, 0.0, 1.0) : u_xlat3;
        u_xlat3 = (u_xlatb0.y) ? vec4(0.0, 0.5, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb0.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat3;
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat9.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb0.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat0.zw = dFdx(u_xlat0.xy);
            u_xlat0.xy = dFdy(u_xlat0.xy);
            u_xlat3.x = dot(u_xlat0.zw, u_xlat0.zw);
            u_xlat12.x = dot(u_xlat0.xy, u_xlat0.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat0 = u_xlat0 * u_xlat12.xxxx;
            u_xlat0 = u_xlat0 / u_xlat3.xxxx;
            u_xlat9.z = dot(abs(u_xlat0.zw), abs(u_xlat0.zw));
            u_xlat9.x = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
            u_xlat3.xy = sqrt(u_xlat9.zx);
            u_xlat9.z = inversesqrt(u_xlat9.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat0.xz = u_xlat9.xz * abs(u_xlat0.xz);
            u_xlat0.x = u_xlat0.x * u_xlat0.z;
            u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
            u_xlat0.x = sqrt(u_xlat0.x);
            u_xlat9.x = u_xlat3.y * u_xlat3.x;
            u_xlat18.x = u_xlat0.x * u_xlat9.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat27 = fract((-u_xlat3.x));
            u_xlat27 = u_xlat27 + 0.5;
            u_xlat27 = floor(u_xlat27);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat27 = u_xlat27 + (-u_xlat3.x);
            u_xlat27 = u_xlat27 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat9.x) * u_xlat0.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat27)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat27);
            u_xlatb3.xy = lessThan(u_xlat18.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat27) * vec3(0.0, 1.0, 0.0);
            u_xlat0.x = u_xlat9.x * u_xlat0.x + -4.0;
            u_xlat0.x = exp2(u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
            u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
            u_xlat0.xyz = u_xlat0.xxx * u_xlat12.zyy + vec3(u_xlat27);
            u_xlat0.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat0.xyz;
            u_xlat0.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat0.xyz;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb27 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb27 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb27){
                u_xlat3.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat27 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat27 = max(u_xlat27, u_xlat4.x);
                u_xlat27 = log2(u_xlat27);
                u_xlat27 = u_xlat27 * 0.5;
                u_xlat27 = max(u_xlat27, 0.0);
                u_xlat27 = u_xlat27 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat27);
                u_xlat27 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat27);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat27 = inversesqrt(u_xlat27);
                u_xlat27 = u_xlat27 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat27 = u_xlat27 * u_xlat3.x;
                u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                u_xlat27 = sqrt(u_xlat27);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat27 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat27 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat27 = u_xlat3.x * u_xlat27 + -4.0;
                u_xlat27 = exp2(u_xlat27);
                u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat0.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb27 = !!(u_xlat1.x>=u_xlat2.x);
#else
                u_xlatb27 = u_xlat1.x>=u_xlat2.x;
#endif
                if(u_xlatb27){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat21.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat27);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat27);
                    u_xlat21.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat3.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat21.x * u_xlat12.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat2.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat2.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat2.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat28 = sqrt(u_xlat27);
                    u_xlat2.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat1.z);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat28 * u_xlat2.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat2.x = fract((-u_xlat19.x));
                    u_xlat2.x = u_xlat2.x + 0.5;
                    u_xlat2.x = floor(u_xlat2.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat2.x = (-u_xlat19.x) + u_xlat2.x;
                    u_xlat19.x = u_xlat2.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat2.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat4.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat4.xyz : u_xlat2.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat3.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        u_xlat0 = vs_TEXCOORD0.zzzz * vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb27 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb27) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ScreenParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump float _SSAO_Intensity;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Texture_1_Tiling;
uniform 	mediump float _Texture_2_Tiling;
uniform 	mediump float _Texture_3_Tiling;
uniform 	mediump float _Texture_4_Tiling;
uniform 	mediump float _Texture_5_Tiling;
uniform 	mediump float _Texture_6_Tiling;
uniform 	mediump float _Texture_7_Tiling;
uniform 	mediump float _Texture_8_Tiling;
uniform 	vec4 _Texture_1_Albedo_TexelSize;
uniform 	vec4 _Texture_2_Albedo_TexelSize;
uniform 	vec4 _Texture_3_Albedo_TexelSize;
uniform 	vec4 _Texture_4_Albedo_TexelSize;
uniform 	vec4 _Texture_5_Albedo_TexelSize;
uniform 	vec4 _Texture_6_Albedo_TexelSize;
uniform 	vec4 _Texture_7_Albedo_TexelSize;
uniform 	vec4 _Texture_8_Albedo_TexelSize;
uniform 	vec4 _Texture_1_Normal_TexelSize;
uniform 	vec4 _Texture_2_Normal_TexelSize;
uniform 	vec4 _Texture_3_Normal_TexelSize;
uniform 	vec4 _Texture_4_Normal_TexelSize;
uniform 	vec4 _Texture_5_Normal_TexelSize;
uniform 	vec4 _Texture_6_Normal_TexelSize;
uniform 	vec4 _Texture_7_Normal_TexelSize;
uniform 	vec4 _Texture_8_Normal_TexelSize;
struct DebugView_PropsArray_Type {
	float _TerrainLODLevel;
};
layout(std140) uniform UnityInstancing_DebugView_Props {
	DebugView_PropsArray_Type DebugView_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Texture_Splat_1;
uniform lowp sampler2D _Texture_Splat_2;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
ivec3 u_xlati3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec2 u_xlatb6;
vec4 u_xlat7;
vec4 u_xlat8;
vec3 u_xlat9;
bvec2 u_xlatb9;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
bvec2 u_xlatb18;
vec2 u_xlat19;
vec2 u_xlat21;
bvec2 u_xlatb21;
vec2 u_xlat23;
vec2 u_xlat24;
vec2 u_xlat25;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat30;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.z<1.5);
#else
    u_xlatb0.x = vs_TEXCOORD0.z<1.5;
#endif
    u_xlatb9.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), _MainTex_TexelSize.zwzz).xy;
    u_xlatb9.x = u_xlatb9.y || u_xlatb9.x;
    u_xlat1.xy = _MainTex_TexelSize.zw;
    u_xlat1.zw = vs_TEXCOORD0.xy;
    u_xlat1 = (u_xlatb9.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat1 = (u_xlatb0.x) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
    u_xlat2.x = float(4096.0);
    u_xlat2.y = float(4096.0);
    u_xlat2.zw = vs_TEXCOORD0.xy;
    u_xlat2 = (u_xlatb0.x) ? u_xlat2 : vec4(1.0, 1.0, 0.0, 0.0);
    if(!u_xlatb0.x){
        u_xlat0 = texture(_Texture_Splat_1, vs_TEXCOORD0.xy);
        u_xlatb0 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat0);
        u_xlat3.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat1.xyxx, u_xlat3.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat4.xy = _Texture_1_Albedo_TexelSize.zw;
        u_xlat4.zw = vs_TEXCOORD2.xz;
        u_xlat4 = (u_xlati3.x != 0) ? u_xlat4 : u_xlat1;
        u_xlat21.xy = vec2(float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.z, float(_Texture_1_Tiling) * _Texture_1_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat2.yyyy, u_xlat21.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat5.xy = _Texture_1_Normal_TexelSize.zw;
        u_xlat5.zw = vs_TEXCOORD2.xz;
        u_xlat5 = (u_xlati3.z != 0) ? u_xlat5 : u_xlat2;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_1_Tiling) : float(1.0);
        u_xlat4 = (u_xlatb0.x) ? u_xlat4 : u_xlat1;
        u_xlat5 = (u_xlatb0.x) ? u_xlat5 : u_xlat2;
        u_xlat3.xy = (u_xlatb0.x) ? u_xlat3.xy : vec2(1.0, 1.0);
        u_xlat21.xy = u_xlat3.xx * u_xlat4.xy;
        u_xlat6.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Albedo_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat6.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat6.xy = _Texture_2_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
        u_xlat7.x = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.x;
        u_xlat21.xy = u_xlat3.yy * u_xlat5.xy;
        u_xlat25.xy = vec2(float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.z, float(_Texture_2_Tiling) * _Texture_2_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat25.xyxy).xy;
        u_xlatb0.x = u_xlatb21.y || u_xlatb21.x;
        u_xlat8.xy = _Texture_2_Normal_TexelSize.zw;
        u_xlat8.zw = vs_TEXCOORD2.xz;
        u_xlat8 = (u_xlatb0.x) ? u_xlat8 : u_xlat5;
        u_xlat7.y = (u_xlatb0.x) ? _Texture_2_Tiling : u_xlat3.y;
        u_xlat4 = (u_xlatb0.y) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.y) ? u_xlat8 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.y) ? u_xlat7.xy : u_xlat3.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlati3.x = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
        u_xlat6.xy = _Texture_3_Albedo_TexelSize.zw;
        u_xlat6.zw = vs_TEXCOORD2.xz;
        u_xlat6 = (u_xlati3.x != 0) ? u_xlat6 : u_xlat4;
        u_xlat21.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat7.xy = vec2(float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.z, float(_Texture_3_Tiling) * _Texture_3_Normal_TexelSize.w);
        u_xlatb21.xy = lessThan(u_xlat21.xyxy, u_xlat7.xyxy).xy;
        u_xlati3.z = int(uint(u_xlatb21.y) * 0xffffffffu | uint(u_xlatb21.x) * 0xffffffffu);
        u_xlat7.xy = _Texture_3_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlati3.z != 0) ? u_xlat7 : u_xlat5;
        u_xlat3.x = (u_xlati3.x != 0) ? float(_Texture_3_Tiling) : u_xlat0.x;
        u_xlat3.y = (u_xlati3.z != 0) ? float(_Texture_3_Tiling) : u_xlat0.y;
        u_xlat4 = (u_xlatb0.z) ? u_xlat6 : u_xlat4;
        u_xlat5 = (u_xlatb0.z) ? u_xlat7 : u_xlat5;
        u_xlat0.xy = (u_xlatb0.z) ? u_xlat3.xy : u_xlat0.xy;
        u_xlat3.xy = u_xlat0.xx * u_xlat4.xy;
        u_xlat21.xy = vec2(_Texture_4_Tiling * _Texture_4_Albedo_TexelSize.z, _Texture_4_Tiling * _Texture_4_Albedo_TexelSize.w);
        u_xlatb3.xy = lessThan(u_xlat3.xyxx, u_xlat21.xyxx).xy;
        u_xlatb18.x = u_xlatb3.y || u_xlatb3.x;
        u_xlat3.xy = _Texture_4_Albedo_TexelSize.zw;
        u_xlat3.zw = vs_TEXCOORD2.xz;
        u_xlat3 = (u_xlatb18.x) ? u_xlat3 : u_xlat4;
        u_xlat6.xy = u_xlat0.yy * u_xlat5.xy;
        u_xlat24.xy = vec2(_Texture_4_Tiling * _Texture_4_Normal_TexelSize.z, _Texture_4_Tiling * _Texture_4_Normal_TexelSize.w);
        u_xlatb6.xy = lessThan(u_xlat6.xyxx, u_xlat24.xyxx).xy;
        u_xlatb6.x = u_xlatb6.y || u_xlatb6.x;
        u_xlat7.xy = _Texture_4_Normal_TexelSize.zw;
        u_xlat7.zw = vs_TEXCOORD2.xz;
        u_xlat7 = (u_xlatb6.x) ? u_xlat7 : u_xlat5;
        u_xlat1 = (u_xlatb0.w) ? u_xlat3 : u_xlat4;
        u_xlat2 = (u_xlatb0.w) ? u_xlat7 : u_xlat5;
#ifdef UNITY_ADRENO_ES3
        u_xlatb3.x = !!(2.5<vs_TEXCOORD0.z);
#else
        u_xlatb3.x = 2.5<vs_TEXCOORD0.z;
#endif
        if(u_xlatb3.x){
            u_xlat3.x = (u_xlatb18.x) ? _Texture_4_Tiling : u_xlat0.x;
            u_xlat3.y = (u_xlatb6.x) ? _Texture_4_Tiling : u_xlat0.y;
            u_xlat0.xy = (u_xlatb0.w) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat3 = texture(_Texture_Splat_2, vs_TEXCOORD0.xy);
            u_xlatb3 = lessThan(vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat3);
            u_xlat18.xy = u_xlat0.xx * u_xlat1.xy;
            u_xlat4.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat4.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat4.xy = _Texture_5_Albedo_TexelSize.zw;
            u_xlat4.zw = vs_TEXCOORD2.xz;
            u_xlat4 = (u_xlatb18.x) ? u_xlat4 : u_xlat1;
            u_xlat5.x = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat2.xy;
            u_xlat23.xy = vec2(float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.z, float(_Texture_5_Tiling) * _Texture_5_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat23.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_5_Normal_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat2;
            u_xlat5.y = (u_xlatb18.x) ? _Texture_5_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.x) ? u_xlat4 : u_xlat1;
            u_xlat6 = (u_xlatb3.x) ? u_xlat6 : u_xlat2;
            u_xlat0.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat5.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat5.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat5.xy = _Texture_6_Albedo_TexelSize.zw;
            u_xlat5.zw = vs_TEXCOORD2.xz;
            u_xlat5 = (u_xlatb18.x) ? u_xlat5 : u_xlat4;
            u_xlat7.x = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat6.xy;
            u_xlat25.xy = vec2(float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.z, float(_Texture_6_Tiling) * _Texture_6_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat25.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat8.xy = _Texture_6_Normal_TexelSize.zw;
            u_xlat8.zw = vs_TEXCOORD2.xz;
            u_xlat8 = (u_xlatb18.x) ? u_xlat8 : u_xlat6;
            u_xlat7.y = (u_xlatb18.x) ? _Texture_6_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.y) ? u_xlat5 : u_xlat4;
            u_xlat5 = (u_xlatb3.y) ? u_xlat8 : u_xlat6;
            u_xlat0.xy = (u_xlatb3.y) ? u_xlat7.xy : u_xlat0.xy;
            u_xlat18.xy = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Albedo_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat3.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat6.xy = _Texture_7_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb18.x) ? u_xlat6 : u_xlat4;
            u_xlat3.x = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.x;
            u_xlat18.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat7.xy = vec2(float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.z, float(_Texture_7_Tiling) * _Texture_7_Normal_TexelSize.w);
            u_xlatb18.xy = lessThan(u_xlat18.xyxy, u_xlat7.xyxy).xy;
            u_xlatb18.x = u_xlatb18.y || u_xlatb18.x;
            u_xlat7.xy = _Texture_7_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat7 = (u_xlatb18.x) ? u_xlat7 : u_xlat5;
            u_xlat3.y = (u_xlatb18.x) ? _Texture_7_Tiling : u_xlat0.y;
            u_xlat4 = (u_xlatb3.z) ? u_xlat6 : u_xlat4;
            u_xlat5 = (u_xlatb3.z) ? u_xlat7 : u_xlat5;
            u_xlat0.xy = (u_xlatb3.z) ? u_xlat3.xy : u_xlat0.xy;
            u_xlat0.xz = u_xlat0.xx * u_xlat4.xy;
            u_xlat3.xy = vec2(_Texture_8_Tiling * _Texture_8_Albedo_TexelSize.z, _Texture_8_Tiling * _Texture_8_Albedo_TexelSize.w);
            u_xlatb0.xz = lessThan(u_xlat0.xxzx, u_xlat3.xxyx).xz;
            u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
            u_xlat6.xy = _Texture_8_Albedo_TexelSize.zw;
            u_xlat6.zw = vs_TEXCOORD2.xz;
            u_xlat6 = (u_xlatb0.x) ? u_xlat6 : u_xlat4;
            u_xlat0.xy = u_xlat0.yy * u_xlat5.xy;
            u_xlat18.xy = vec2(_Texture_8_Tiling * _Texture_8_Normal_TexelSize.z, _Texture_8_Tiling * _Texture_8_Normal_TexelSize.w);
            u_xlatb0.xy = lessThan(u_xlat0.xyxx, u_xlat18.xyxx).xy;
            u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
            u_xlat7.xy = _Texture_8_Normal_TexelSize.zw;
            u_xlat7.zw = vs_TEXCOORD2.xz;
            u_xlat0 = (u_xlatb0.x) ? u_xlat7 : u_xlat5;
            u_xlat1 = (u_xlatb3.w) ? u_xlat6 : u_xlat4;
            u_xlat2 = (u_xlatb3.w) ? u_xlat0 : u_xlat5;
        //ENDIF
        }
    } else {
        u_xlat2 = u_xlat2.yyzw;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
        u_xlatb3 = lessThan(vec4(4.9000001, 3.9000001, 2.9000001, 1.89999998), vec4(DebugView_PropsArray[u_xlati0]._TerrainLODLevel));
        u_xlatb0.xy = lessThan(vec4(0.899999976, -0.100000001, 0.0, 0.0), vec4(DebugView_PropsArray[u_xlati0]._TerrainLODLevel)).xy;
        u_xlat4 = (u_xlatb0.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat0 = (u_xlatb0.x) ? vec4(0.5, 0.0, 0.0, 1.0) : u_xlat4;
        u_xlat0 = (u_xlatb3.w) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (u_xlatb3.z) ? vec4(0.5, 0.5, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (u_xlatb3.y) ? vec4(0.0, 0.5, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat0;
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat9.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9.x = !!(256.0<u_xlat0.x);
#else
        u_xlatb9.x = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat3 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat3 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat3;
        u_xlat0 = (u_xlatb9.x) ? u_xlat3 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb0.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat0.zw = dFdx(u_xlat0.xy);
            u_xlat0.xy = dFdy(u_xlat0.xy);
            u_xlat3.x = dot(u_xlat0.zw, u_xlat0.zw);
            u_xlat12.x = dot(u_xlat0.xy, u_xlat0.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat0 = u_xlat0 * u_xlat12.xxxx;
            u_xlat0 = u_xlat0 / u_xlat3.xxxx;
            u_xlat9.z = dot(abs(u_xlat0.zw), abs(u_xlat0.zw));
            u_xlat9.x = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
            u_xlat3.xy = sqrt(u_xlat9.zx);
            u_xlat9.z = inversesqrt(u_xlat9.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat0.xz = u_xlat9.xz * abs(u_xlat0.xz);
            u_xlat0.x = u_xlat0.x * u_xlat0.z;
            u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
            u_xlat0.x = sqrt(u_xlat0.x);
            u_xlat9.x = u_xlat3.y * u_xlat3.x;
            u_xlat18.x = u_xlat0.x * u_xlat9.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat27 = fract((-u_xlat3.x));
            u_xlat27 = u_xlat27 + 0.5;
            u_xlat27 = floor(u_xlat27);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat27 = u_xlat27 + (-u_xlat3.x);
            u_xlat27 = u_xlat27 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat9.x) * u_xlat0.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat27)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat27);
            u_xlatb3.xy = lessThan(u_xlat18.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat27) * vec3(0.0, 1.0, 0.0);
            u_xlat0.x = u_xlat9.x * u_xlat0.x + -4.0;
            u_xlat0.x = exp2(u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
            u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
            u_xlat0.xyz = u_xlat0.xxx * u_xlat12.zyy + vec3(u_xlat27);
            u_xlat0.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat0.xyz;
            u_xlat0.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat0.xyz;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb27 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb27 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb27){
                u_xlat3.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat27 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat27 = max(u_xlat27, u_xlat4.x);
                u_xlat27 = log2(u_xlat27);
                u_xlat27 = u_xlat27 * 0.5;
                u_xlat27 = max(u_xlat27, 0.0);
                u_xlat27 = u_xlat27 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat27);
                u_xlat27 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat27);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat27 = inversesqrt(u_xlat27);
                u_xlat27 = u_xlat27 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat27 = u_xlat27 * u_xlat3.x;
                u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                u_xlat27 = sqrt(u_xlat27);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat27 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat27 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat27 = u_xlat3.x * u_xlat27 + -4.0;
                u_xlat27 = exp2(u_xlat27);
                u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat0.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb27 = !!(u_xlat1.x>=u_xlat2.x);
#else
                u_xlatb27 = u_xlat1.x>=u_xlat2.x;
#endif
                if(u_xlatb27){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat21.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat27);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat27);
                    u_xlat21.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat3.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat21.x * u_xlat12.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat1.xy = vec2(u_xlat2.x * u_xlat2.z, u_xlat2.y * u_xlat2.w);
                    u_xlat1.zw = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat1.zw, u_xlat1.zw);
                    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat2.x);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat2.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1 = u_xlat1 * u_xlat2.xxxx;
                    u_xlat1 = u_xlat1 / vec4(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat1.zw), abs(u_xlat1.zw));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat28 = sqrt(u_xlat27);
                    u_xlat2.x = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat1.z);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat28 * u_xlat2.x;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat2.z * float(3.0), u_xlat2.w * float(3.0));
                    u_xlat2.x = fract((-u_xlat19.x));
                    u_xlat2.x = u_xlat2.x + 0.5;
                    u_xlat2.x = floor(u_xlat2.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat2.x = (-u_xlat19.x) + u_xlat2.x;
                    u_xlat19.x = u_xlat2.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat1.x) * u_xlat27 + 1.0;
                    u_xlat2.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat28) * u_xlat2.xyz + u_xlat19.xxx;
                    u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat4.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat27 = u_xlat1.x * u_xlat27 + -4.0;
                    u_xlat27 = exp2(u_xlat27);
                    u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
                    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
                    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.zyy + u_xlat19.xxx;
                    u_xlat1.xzw = (u_xlatb10.z) ? u_xlat4.xyz : u_xlat2.xyz;
                    u_xlat0.xyz = (u_xlatb10.x) ? u_xlat3.xyz : u_xlat1.xzw;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        u_xlat0 = vs_TEXCOORD0.zzzz * vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target2.w = u_xlat10_0.w * _Terrain_Smoothness;
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb27 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb27) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat10_0.xyz;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
uniform 	vec4 _InstanceParam0;
uniform 	vec4 _InstanceParam1;
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlat0.x = dot(_InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xy = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xy = u_xlat0.xy + _InstanceParam0.xy;
    u_xlat6.xy = u_xlat0.xy * _InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xy * _InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat6.x / _BlockParam1.z, u_xlat6.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 hlslcc_mtx4x4terrain_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4terrain_WorldToObject[4];
uniform 	vec4 _BlockParam0;
uniform 	vec4 _BlockParam1;
struct BuiltinTerrain_PropsArray_Type {
	vec4 _InstanceParam0;
	vec4 _InstanceParam1;
};
layout(std140) uniform UnityInstancing_BuiltinTerrain_Props {
	BuiltinTerrain_PropsArray_Type BuiltinTerrain_PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _HeightMap;
uniform lowp sampler2D _VertexNormalMap;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatu0 = uint(in_TEXCOORD0.z);
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 1;
    u_xlat0.x = dot(BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam1, ImmCB_0_0_0[int(u_xlatu0)]);
    u_xlat0.xz = in_TEXCOORD0.xy * u_xlat0.xx + in_POSITION0.xz;
    u_xlat0.xz = u_xlat0.xz + BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.xy;
    u_xlat1.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz + (-_BlockParam1.xy);
    u_xlat0.xy = u_xlat0.xz * BuiltinTerrain_PropsArray[u_xlati3 / 2]._InstanceParam0.zz;
    u_xlat6.xy = vec2(u_xlat1.x / _BlockParam1.z, u_xlat1.y / _BlockParam1.w);
    u_xlat1.x = textureLod(_HeightMap, u_xlat6.xy, 0.0).x;
    u_xlat6.xy = textureLod(_VertexNormalMap, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0) + vec2(-2.0, -2.0);
    u_xlat1 = u_xlat1.xxxx * hlslcc_mtx4x4terrain_ObjectToWorld[1];
    u_xlat2.xy = vec2(u_xlat0.x * _BlockParam0.z, u_xlat0.y * _BlockParam0.w);
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4terrain_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4terrain_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4terrain_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = _BlockParam0.xy + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(1.0, 0.0);
    u_xlat0.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat2.zw = (-u_xlat0.xx) * vec2(0.25, 0.5) + vec2(1.0, 1.0);
    u_xlat0.x = sqrt(u_xlat2.z);
    u_xlat2.xy = u_xlat0.xx * u_xlat6.xy;
    u_xlat0.x = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[0].xyz);
    u_xlat0.y = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[1].xyz);
    u_xlat0.z = dot(u_xlat2.xyw, hlslcc_mtx4x4terrain_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
}
}
}
Fallback "Diffuse"
}