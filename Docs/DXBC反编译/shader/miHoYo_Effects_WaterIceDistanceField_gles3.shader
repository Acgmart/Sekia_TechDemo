//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/WaterIceDistanceField" {
Properties {
_BlockSize ("BlockSize", Float) = 0
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 61081
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_FrozenDegree[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
ivec4 u_xlati0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
float u_xlat6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.zzxx + vec4(1.49000001, 1.50999999, 1.49000001, 1.50999999);
    u_xlat0 = floor(u_xlat0);
    u_xlati0 = ivec4(u_xlat0);
    u_xlat1.x = dot(hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat1.y = dot(hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat1.z = dot(hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat1.w = dot(hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.z]);
    u_xlat1.x = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.w]);
    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
    u_xlat1.x = dot(hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat1.y = dot(hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat1.z = dot(hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat1.w = dot(hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat2 = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.z]);
    u_xlat4 = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.w]);
    u_xlat0.x = min(u_xlat0.x, u_xlat2);
    u_xlat0.x = min(u_xlat0.x, u_xlat4);
    vs_TEXCOORD2 = u_xlat0.x * in_COLOR0.x;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_POSITION0.xz;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(vs_TEXCOORD2);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

vec4 ImmCB_0_0_0[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_FrozenDegree[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
ivec4 u_xlati0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
float u_xlat6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.zzxx + vec4(1.49000001, 1.50999999, 1.49000001, 1.50999999);
    u_xlat0 = floor(u_xlat0);
    u_xlati0 = ivec4(u_xlat0);
    u_xlat1.x = dot(hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat1.y = dot(hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat1.z = dot(hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat1.w = dot(hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati0.x]);
    u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.z]);
    u_xlat1.x = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.w]);
    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
    u_xlat1.x = dot(hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat1.y = dot(hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat1.z = dot(hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat1.w = dot(hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati0.y]);
    u_xlat2 = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.z]);
    u_xlat4 = dot(u_xlat1, ImmCB_0_0_0[u_xlati0.w]);
    u_xlat0.x = min(u_xlat0.x, u_xlat2);
    u_xlat0.x = min(u_xlat0.x, u_xlat4);
    vs_TEXCOORD2 = u_xlat0.x * in_COLOR0.x;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xy = in_POSITION0.xz;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(vs_TEXCOORD2);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct miHoYoEffectWaterIceDistanceFieldArray_Type {
	vec4 hlslcc_mtx4x4_FrozenDegree[4];
};
layout(std140) uniform UnityInstancing_miHoYoEffectWaterIceDistanceField {
	miHoYoEffectWaterIceDistanceFieldArray_Type miHoYoEffectWaterIceDistanceFieldArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
ivec4 u_xlati1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(2, 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.zzxx + vec4(1.49000001, 1.50999999, 1.49000001, 1.50999999);
    u_xlat1 = floor(u_xlat1);
    u_xlati1 = ivec4(u_xlat1);
    u_xlat2.x = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat2.y = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat2.z = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat2.w = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat6 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.z]);
    u_xlat9 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.w]);
    u_xlat6 = min(u_xlat6, u_xlat9);
    u_xlat2.x = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat2.y = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat2.z = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat2.w = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat0 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.z]);
    u_xlat9 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.w]);
    u_xlat0 = min(u_xlat6, u_xlat0);
    u_xlat0 = min(u_xlat0, u_xlat9);
    vs_TEXCOORD2 = u_xlat0 * in_COLOR0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD0.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD3.xy = in_POSITION0.xz;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(vs_TEXCOORD2);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

vec4 ImmCB_0_0_0[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct miHoYoEffectWaterIceDistanceFieldArray_Type {
	vec4 hlslcc_mtx4x4_FrozenDegree[4];
};
layout(std140) uniform UnityInstancing_miHoYoEffectWaterIceDistanceField {
	miHoYoEffectWaterIceDistanceFieldArray_Type miHoYoEffectWaterIceDistanceFieldArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
ivec4 u_xlati1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(2, 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD1.xyz = unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1 = in_POSITION0.zzxx + vec4(1.49000001, 1.50999999, 1.49000001, 1.50999999);
    u_xlat1 = floor(u_xlat1);
    u_xlati1 = ivec4(u_xlat1);
    u_xlat2.x = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat2.y = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat2.z = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat2.w = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati1.x]);
    u_xlat6 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.z]);
    u_xlat9 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.w]);
    u_xlat6 = min(u_xlat6, u_xlat9);
    u_xlat2.x = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[0], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat2.y = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[1], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat2.z = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[2], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat2.w = dot(miHoYoEffectWaterIceDistanceFieldArray[u_xlati0.x / 4].hlslcc_mtx4x4_FrozenDegree[3], ImmCB_0_0_0[u_xlati1.y]);
    u_xlat0 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.z]);
    u_xlat9 = dot(u_xlat2, ImmCB_0_0_0[u_xlati1.w]);
    u_xlat0 = min(u_xlat6, u_xlat0);
    u_xlat0 = min(u_xlat0, u_xlat9);
    vs_TEXCOORD2 = u_xlat0 * in_COLOR0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.y / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD0.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD3.xy = in_POSITION0.xz;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(vs_TEXCOORD2);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}