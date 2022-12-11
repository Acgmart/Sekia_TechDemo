//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Terrain/BlendStoneHLOD New" {
Properties {
[Header(Main Setting)] _BumpMap ("Normalmap", 2D) = "bump" { }
_DefaultSmoothness_HLOD ("HLOD Default Smoothness", Range(0.01, 0.8)) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 24233
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
float u_xlat14;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_1.x);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat16_1.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    u_xlat16_13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_13 = inversesqrt(u_xlat16_13);
    u_xlat16_3.xyz = vec3(u_xlat16_13) * u_xlat2.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat16_3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat2.xyz;
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
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat4.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat4.y;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat4.z;
    vs_TEXCOORD5.z = u_xlat4.x;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
float u_xlat14;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_1.x);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat16_1.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    u_xlat16_13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_13 = inversesqrt(u_xlat16_13);
    u_xlat16_3.xyz = vec3(u_xlat16_13) * u_xlat2.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat16_3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat2.xyz;
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
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 111682
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
  Name "HYBRIDDEFERRED"
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 151786
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_4;
float u_xlat11;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_1.x);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat16_1.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    SV_Target1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    u_xlat16_1.x = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_2 = min(u_xlat16_2, 0.999000013);
    u_xlat16_4 = (-u_xlat16_2) + 1.0;
    SV_Target2.w = u_xlat16_1.x * u_xlat16_4 + u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb2) ? 0.0 : 0.0399999991;
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
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat4.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat4.y;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat4.z;
    vs_TEXCOORD5.z = u_xlat4.x;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_4;
float u_xlat11;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_1.x);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat16_1.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    SV_Target1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    u_xlat16_1.x = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_2 = min(u_xlat16_2, 0.999000013);
    u_xlat16_4 = (-u_xlat16_2) + 1.0;
    SV_Target2.w = u_xlat16_1.x * u_xlat16_4 + u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb2) ? 0.0 : 0.0399999991;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat9;
bool u_xlatb9;
vec3 u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat20;
vec2 u_xlat21;
float u_xlat27;
float u_xlat28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlatb0.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb0.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (u_xlatb0.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
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
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
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
        u_xlat0.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat9 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat1.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xyxx).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat0.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (u_xlatb1.x) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
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
            u_xlat12.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat12.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat11.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat11.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat11.zx);
            u_xlat11.z = inversesqrt(u_xlat11.z);
            u_xlat11.x = inversesqrt(u_xlat11.x);
            u_xlat2.xz = u_xlat11.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat11.x = u_xlat3.y * u_xlat3.x;
            u_xlat20 = u_xlat2.x * u_xlat11.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat29 = fract((-u_xlat3.x));
            u_xlat29 = u_xlat29 + 0.5;
            u_xlat29 = floor(u_xlat29);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat29 = u_xlat29 + (-u_xlat3.x);
            u_xlat29 = u_xlat29 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat11.x) * u_xlat2.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat29)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat29);
            u_xlatb3.xy = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat29) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat11.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat12.zyy + vec3(u_xlat29);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb29 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb29)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb29 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb29 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb29){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat29 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat29 = max(u_xlat29, u_xlat4.x);
                u_xlat29 = log2(u_xlat29);
                u_xlat29 = u_xlat29 * 0.5;
                u_xlat29 = max(u_xlat29, 0.0);
                u_xlat29 = u_xlat29 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat29);
                u_xlat29 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat29);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat29 = inversesqrt(u_xlat29);
                u_xlat29 = u_xlat29 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat29 = u_xlat29 * u_xlat3.x;
                u_xlat29 = (-u_xlat29) * u_xlat29 + 1.0;
                u_xlat29 = sqrt(u_xlat29);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat29 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat29 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat29 = u_xlat3.x * u_xlat29 + -4.0;
                u_xlat29 = exp2(u_xlat29);
                u_xlat29 = u_xlat29 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
                u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat29) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb29 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb29 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb29){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat29 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat29 = max(u_xlat29, u_xlat21.x);
                    u_xlat29 = log2(u_xlat29);
                    u_xlat29 = u_xlat29 * 0.5;
                    u_xlat29 = max(u_xlat29, 0.0);
                    u_xlat29 = u_xlat29 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat29);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat29);
                    u_xlat29 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat29);
                    u_xlat21.x = sqrt(u_xlat10.x);
                    u_xlat29 = inversesqrt(u_xlat29);
                    u_xlat29 = u_xlat29 * abs(u_xlat3.x);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat29;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat10.x = u_xlat21.x * u_xlat12.x;
                    u_xlat29 = u_xlat1.x * u_xlat10.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat10.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat29), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat10.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat19.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat28 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat19.x = max(u_xlat28, u_xlat19.x);
                    u_xlat19.x = log2(u_xlat19.x);
                    u_xlat19.x = u_xlat19.x * 0.5;
                    u_xlat19.x = max(u_xlat19.x, 0.0);
                    u_xlat19.x = u_xlat19.x + 1.0;
                    u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat28) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat28);
                    u_xlat1.xy = u_xlat1.xy / u_xlat19.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat19.xx;
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat9 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat19.x = sqrt(u_xlat10.x);
                    u_xlat28 = sqrt(u_xlat9);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat0.x = u_xlat9 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat9 = u_xlat28 * u_xlat19.x;
                    u_xlat1.x = u_xlat0.x * u_xlat9;
                    u_xlat18.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat10.x = fract((-u_xlat18.x));
                    u_xlat10.x = u_xlat10.x + 0.5;
                    u_xlat10.x = floor(u_xlat10.x);
                    u_xlat18.xy = fract(u_xlat18.xy);
                    u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                    u_xlat18.xy = floor(u_xlat18.xy);
                    u_xlat10.x = (-u_xlat18.x) + u_xlat10.x;
                    u_xlat18.x = u_xlat10.x * u_xlat18.y + u_xlat18.x;
                    u_xlat27 = (-u_xlat9) * u_xlat0.x + 1.0;
                    u_xlat10.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat18.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat9 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.zyy + u_xlat18.xxx;
                    u_xlat0.xyz = (u_xlatb1.y) ? u_xlat4.xyz : u_xlat0.xyz;
                    u_xlat2.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat0.xyz;
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
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    u_xlat16_34 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_34 = (-u_xlat16_34) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_34);
    u_xlat16_1 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat16_34 = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16_1) + 1.0;
    SV_Target2.w = u_xlat16_34 * u_xlat16_8 + u_xlat16_1;
    SV_Target1.xyz = u_xlat16_7.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb1.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
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
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat4.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat4.y;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat4.z;
    vs_TEXCOORD5.z = u_xlat4.x;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat9;
bool u_xlatb9;
vec3 u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat20;
vec2 u_xlat21;
float u_xlat27;
float u_xlat28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlatb0.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb0.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (u_xlatb0.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
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
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
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
        u_xlat0.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat9 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat1.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xyxx).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat0.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (u_xlatb1.x) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
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
            u_xlat12.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat12.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat11.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat11.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat11.zx);
            u_xlat11.z = inversesqrt(u_xlat11.z);
            u_xlat11.x = inversesqrt(u_xlat11.x);
            u_xlat2.xz = u_xlat11.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat11.x = u_xlat3.y * u_xlat3.x;
            u_xlat20 = u_xlat2.x * u_xlat11.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat29 = fract((-u_xlat3.x));
            u_xlat29 = u_xlat29 + 0.5;
            u_xlat29 = floor(u_xlat29);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat29 = u_xlat29 + (-u_xlat3.x);
            u_xlat29 = u_xlat29 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat11.x) * u_xlat2.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat29)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat29);
            u_xlatb3.xy = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat29) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat11.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat12.zyy + vec3(u_xlat29);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb29 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb29)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb29 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb29 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb29){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat29 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat29 = max(u_xlat29, u_xlat4.x);
                u_xlat29 = log2(u_xlat29);
                u_xlat29 = u_xlat29 * 0.5;
                u_xlat29 = max(u_xlat29, 0.0);
                u_xlat29 = u_xlat29 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat29);
                u_xlat29 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat29);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat29 = inversesqrt(u_xlat29);
                u_xlat29 = u_xlat29 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat29 = u_xlat29 * u_xlat3.x;
                u_xlat29 = (-u_xlat29) * u_xlat29 + 1.0;
                u_xlat29 = sqrt(u_xlat29);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat29 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat29 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat29 = u_xlat3.x * u_xlat29 + -4.0;
                u_xlat29 = exp2(u_xlat29);
                u_xlat29 = u_xlat29 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
                u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat29) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb29 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb29 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb29){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat29 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat29 = max(u_xlat29, u_xlat21.x);
                    u_xlat29 = log2(u_xlat29);
                    u_xlat29 = u_xlat29 * 0.5;
                    u_xlat29 = max(u_xlat29, 0.0);
                    u_xlat29 = u_xlat29 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat29);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat29);
                    u_xlat29 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat29);
                    u_xlat21.x = sqrt(u_xlat10.x);
                    u_xlat29 = inversesqrt(u_xlat29);
                    u_xlat29 = u_xlat29 * abs(u_xlat3.x);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat29;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat10.x = u_xlat21.x * u_xlat12.x;
                    u_xlat29 = u_xlat1.x * u_xlat10.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat10.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat29), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat10.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat19.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat28 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat19.x = max(u_xlat28, u_xlat19.x);
                    u_xlat19.x = log2(u_xlat19.x);
                    u_xlat19.x = u_xlat19.x * 0.5;
                    u_xlat19.x = max(u_xlat19.x, 0.0);
                    u_xlat19.x = u_xlat19.x + 1.0;
                    u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat28) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat28);
                    u_xlat1.xy = u_xlat1.xy / u_xlat19.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat19.xx;
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat9 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat19.x = sqrt(u_xlat10.x);
                    u_xlat28 = sqrt(u_xlat9);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat0.x = u_xlat9 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat9 = u_xlat28 * u_xlat19.x;
                    u_xlat1.x = u_xlat0.x * u_xlat9;
                    u_xlat18.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat10.x = fract((-u_xlat18.x));
                    u_xlat10.x = u_xlat10.x + 0.5;
                    u_xlat10.x = floor(u_xlat10.x);
                    u_xlat18.xy = fract(u_xlat18.xy);
                    u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                    u_xlat18.xy = floor(u_xlat18.xy);
                    u_xlat10.x = (-u_xlat18.x) + u_xlat10.x;
                    u_xlat18.x = u_xlat10.x * u_xlat18.y + u_xlat18.x;
                    u_xlat27 = (-u_xlat9) * u_xlat0.x + 1.0;
                    u_xlat10.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat18.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat9 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.zyy + u_xlat18.xxx;
                    u_xlat0.xyz = (u_xlatb1.y) ? u_xlat4.xyz : u_xlat0.xyz;
                    u_xlat2.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat0.xyz;
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
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    u_xlat16_34 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_34 = (-u_xlat16_34) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_34);
    u_xlat16_1 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat16_34 = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16_1) + 1.0;
    SV_Target2.w = u_xlat16_34 * u_xlat16_8 + u_xlat16_1;
    SV_Target1.xyz = u_xlat16_7.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb1.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_4;
float u_xlat11;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_1.x);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat16_1.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    SV_Target1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    u_xlat16_1.x = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_2 = min(u_xlat16_2, 0.999000013);
    u_xlat16_4 = (-u_xlat16_2) + 1.0;
    SV_Target2.w = u_xlat16_1.x * u_xlat16_4 + u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb2) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat4.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat4.y;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat4.z;
    vs_TEXCOORD5.z = u_xlat4.x;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_4;
float u_xlat11;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_1.x);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat16_1.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    SV_Target1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    u_xlat16_1.x = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_2 = min(u_xlat16_2, 0.999000013);
    u_xlat16_4 = (-u_xlat16_2) + 1.0;
    SV_Target2.w = u_xlat16_1.x * u_xlat16_4 + u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb2) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat9;
bool u_xlatb9;
vec3 u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat20;
vec2 u_xlat21;
float u_xlat27;
float u_xlat28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlatb0.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb0.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (u_xlatb0.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
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
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
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
        u_xlat0.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat9 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat1.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xyxx).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat0.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (u_xlatb1.x) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
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
            u_xlat12.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat12.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat11.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat11.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat11.zx);
            u_xlat11.z = inversesqrt(u_xlat11.z);
            u_xlat11.x = inversesqrt(u_xlat11.x);
            u_xlat2.xz = u_xlat11.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat11.x = u_xlat3.y * u_xlat3.x;
            u_xlat20 = u_xlat2.x * u_xlat11.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat29 = fract((-u_xlat3.x));
            u_xlat29 = u_xlat29 + 0.5;
            u_xlat29 = floor(u_xlat29);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat29 = u_xlat29 + (-u_xlat3.x);
            u_xlat29 = u_xlat29 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat11.x) * u_xlat2.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat29)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat29);
            u_xlatb3.xy = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat29) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat11.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat12.zyy + vec3(u_xlat29);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb29 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb29)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb29 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb29 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb29){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat29 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat29 = max(u_xlat29, u_xlat4.x);
                u_xlat29 = log2(u_xlat29);
                u_xlat29 = u_xlat29 * 0.5;
                u_xlat29 = max(u_xlat29, 0.0);
                u_xlat29 = u_xlat29 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat29);
                u_xlat29 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat29);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat29 = inversesqrt(u_xlat29);
                u_xlat29 = u_xlat29 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat29 = u_xlat29 * u_xlat3.x;
                u_xlat29 = (-u_xlat29) * u_xlat29 + 1.0;
                u_xlat29 = sqrt(u_xlat29);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat29 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat29 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat29 = u_xlat3.x * u_xlat29 + -4.0;
                u_xlat29 = exp2(u_xlat29);
                u_xlat29 = u_xlat29 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
                u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat29) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb29 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb29 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb29){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat29 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat29 = max(u_xlat29, u_xlat21.x);
                    u_xlat29 = log2(u_xlat29);
                    u_xlat29 = u_xlat29 * 0.5;
                    u_xlat29 = max(u_xlat29, 0.0);
                    u_xlat29 = u_xlat29 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat29);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat29);
                    u_xlat29 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat29);
                    u_xlat21.x = sqrt(u_xlat10.x);
                    u_xlat29 = inversesqrt(u_xlat29);
                    u_xlat29 = u_xlat29 * abs(u_xlat3.x);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat29;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat10.x = u_xlat21.x * u_xlat12.x;
                    u_xlat29 = u_xlat1.x * u_xlat10.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat10.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat29), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat10.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat19.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat28 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat19.x = max(u_xlat28, u_xlat19.x);
                    u_xlat19.x = log2(u_xlat19.x);
                    u_xlat19.x = u_xlat19.x * 0.5;
                    u_xlat19.x = max(u_xlat19.x, 0.0);
                    u_xlat19.x = u_xlat19.x + 1.0;
                    u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat28) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat28);
                    u_xlat1.xy = u_xlat1.xy / u_xlat19.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat19.xx;
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat9 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat19.x = sqrt(u_xlat10.x);
                    u_xlat28 = sqrt(u_xlat9);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat0.x = u_xlat9 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat9 = u_xlat28 * u_xlat19.x;
                    u_xlat1.x = u_xlat0.x * u_xlat9;
                    u_xlat18.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat10.x = fract((-u_xlat18.x));
                    u_xlat10.x = u_xlat10.x + 0.5;
                    u_xlat10.x = floor(u_xlat10.x);
                    u_xlat18.xy = fract(u_xlat18.xy);
                    u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                    u_xlat18.xy = floor(u_xlat18.xy);
                    u_xlat10.x = (-u_xlat18.x) + u_xlat10.x;
                    u_xlat18.x = u_xlat10.x * u_xlat18.y + u_xlat18.x;
                    u_xlat27 = (-u_xlat9) * u_xlat0.x + 1.0;
                    u_xlat10.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat18.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat9 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.zyy + u_xlat18.xxx;
                    u_xlat0.xyz = (u_xlatb1.y) ? u_xlat4.xyz : u_xlat0.xyz;
                    u_xlat2.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat0.xyz;
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
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    u_xlat16_34 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_34 = (-u_xlat16_34) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_34);
    u_xlat16_1 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat16_34 = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16_1) + 1.0;
    SV_Target2.w = u_xlat16_34 * u_xlat16_8 + u_xlat16_1;
    SV_Target1.xyz = u_xlat16_7.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb1.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat4.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat4.y;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat4.z;
    vs_TEXCOORD5.z = u_xlat4.x;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	mediump float _DefaultSmoothness_HLOD;
uniform 	mediump vec4 _mhyRainNoiseParam1;
uniform 	mediump float _RainIntensity;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat9;
bool u_xlatb9;
vec3 u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
bvec3 u_xlatb12;
vec2 u_xlat18;
vec2 u_xlat19;
float u_xlat20;
vec2 u_xlat21;
float u_xlat27;
float u_xlat28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        u_xlatb0.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb0.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (u_xlatb0.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
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
        u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
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
        u_xlat0.x = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _GrassDiffuse_TexelSize.z, vs_TEXCOORD0.y * _GrassDiffuse_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat18.x = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat18.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat9 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat9 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(256.0<u_xlat0.x);
#else
        u_xlatb9 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb9)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat0.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat1.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb1.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xyxx).xy;
        u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
        u_xlat0.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (u_xlatb1.x) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
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
            u_xlat12.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat3.x = max(u_xlat12.x, u_xlat3.x);
            u_xlat3.x = log2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x * 0.5;
            u_xlat3.x = max(u_xlat3.x, 0.0);
            u_xlat3.x = u_xlat3.x + 1.0;
            u_xlat12.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat12.xxxx;
            u_xlat2 = u_xlat2 / u_xlat3.xxxx;
            u_xlat11.z = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat11.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat3.xy = sqrt(u_xlat11.zx);
            u_xlat11.z = inversesqrt(u_xlat11.z);
            u_xlat11.x = inversesqrt(u_xlat11.x);
            u_xlat2.xz = u_xlat11.xz * abs(u_xlat2.xz);
            u_xlat2.x = u_xlat2.x * u_xlat2.z;
            u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
            u_xlat2.x = sqrt(u_xlat2.x);
            u_xlat11.x = u_xlat3.y * u_xlat3.x;
            u_xlat20 = u_xlat2.x * u_xlat11.x;
            u_xlat3.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat29 = fract((-u_xlat3.x));
            u_xlat29 = u_xlat29 + 0.5;
            u_xlat29 = floor(u_xlat29);
            u_xlat3.xy = fract(u_xlat3.xy);
            u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
            u_xlat3.xy = floor(u_xlat3.xy);
            u_xlat29 = u_xlat29 + (-u_xlat3.x);
            u_xlat29 = u_xlat29 * u_xlat3.y + u_xlat3.x;
            u_xlat3.x = (-u_xlat11.x) * u_xlat2.x + 1.0;
            u_xlat12.xyz = (-vec3(u_xlat29)) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = u_xlat3.xxx * u_xlat12.xyz + vec3(u_xlat29);
            u_xlatb3.xy = lessThan(vec4(u_xlat20), vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat5.xyz = vec3(u_xlat29) * vec3(0.0, 1.0, 0.0);
            u_xlat2.x = u_xlat11.x * u_xlat2.x + -4.0;
            u_xlat2.x = exp2(u_xlat2.x);
            u_xlat2.x = u_xlat2.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
            u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
            u_xlat2.xyz = u_xlat2.xxx * u_xlat12.zyy + vec3(u_xlat29);
            u_xlat2.xyz = (u_xlatb3.y) ? u_xlat5.xyz : u_xlat2.xyz;
            u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat2.xyz;
        } else {
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb29 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb29)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb29 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb29 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb29){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat29 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat29 = max(u_xlat29, u_xlat4.x);
                u_xlat29 = log2(u_xlat29);
                u_xlat29 = u_xlat29 * 0.5;
                u_xlat29 = max(u_xlat29, 0.0);
                u_xlat29 = u_xlat29 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat29);
                u_xlat29 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat12.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat30 = sqrt(u_xlat29);
                u_xlat4.x = sqrt(u_xlat12.x);
                u_xlat29 = inversesqrt(u_xlat29);
                u_xlat29 = u_xlat29 * abs(u_xlat3.z);
                u_xlat12.x = inversesqrt(u_xlat12.x);
                u_xlat3.x = u_xlat12.x * abs(u_xlat3.x);
                u_xlat29 = u_xlat29 * u_xlat3.x;
                u_xlat29 = (-u_xlat29) * u_xlat29 + 1.0;
                u_xlat29 = sqrt(u_xlat29);
                u_xlat3.x = u_xlat30 * u_xlat4.x;
                u_xlat12.x = u_xlat29 * u_xlat3.x;
                u_xlat21.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat21.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat21.xy = fract(u_xlat21.xy);
                u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                u_xlat21.xy = floor(u_xlat21.xy);
                u_xlat4.x = (-u_xlat21.x) + u_xlat4.x;
                u_xlat21.x = u_xlat4.x * u_xlat21.y + u_xlat21.x;
                u_xlat30 = (-u_xlat3.x) * u_xlat29 + 1.0;
                u_xlat4.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat21.xxx;
                u_xlatb12.xz = lessThan(u_xlat12.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat29 = u_xlat3.x * u_xlat29 + -4.0;
                u_xlat29 = exp2(u_xlat29);
                u_xlat29 = u_xlat29 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
                u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat29) * u_xlat4.zyy + u_xlat21.xxx;
                u_xlat3.xzw = (u_xlatb12.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb12.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb29 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb29 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb29){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat29 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat29 = max(u_xlat29, u_xlat21.x);
                    u_xlat29 = log2(u_xlat29);
                    u_xlat29 = u_xlat29 * 0.5;
                    u_xlat29 = max(u_xlat29, 0.0);
                    u_xlat29 = u_xlat29 + 1.0;
                    u_xlat21.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat21.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat21.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat29);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat29);
                    u_xlat29 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat12.x = sqrt(u_xlat29);
                    u_xlat21.x = sqrt(u_xlat10.x);
                    u_xlat29 = inversesqrt(u_xlat29);
                    u_xlat29 = u_xlat29 * abs(u_xlat3.x);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat29;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat10.x = u_xlat21.x * u_xlat12.x;
                    u_xlat29 = u_xlat1.x * u_xlat10.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat19.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat3.x = (-u_xlat19.x) + u_xlat3.x;
                    u_xlat19.x = u_xlat3.x * u_xlat19.y + u_xlat19.x;
                    u_xlat28 = (-u_xlat10.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat19.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat19.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat29), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat19.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat10.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat19.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat19.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat28 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat19.x = max(u_xlat28, u_xlat19.x);
                    u_xlat19.x = log2(u_xlat19.x);
                    u_xlat19.x = u_xlat19.x * 0.5;
                    u_xlat19.x = max(u_xlat19.x, 0.0);
                    u_xlat19.x = u_xlat19.x + 1.0;
                    u_xlat28 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat28) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat28);
                    u_xlat1.xy = u_xlat1.xy / u_xlat19.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat19.xx;
                    u_xlat10.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat9 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat19.x = sqrt(u_xlat10.x);
                    u_xlat28 = sqrt(u_xlat9);
                    u_xlat10.x = inversesqrt(u_xlat10.x);
                    u_xlat1.x = u_xlat10.x * abs(u_xlat1.x);
                    u_xlat9 = inversesqrt(u_xlat9);
                    u_xlat0.x = u_xlat9 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat9 = u_xlat28 * u_xlat19.x;
                    u_xlat1.x = u_xlat0.x * u_xlat9;
                    u_xlat18.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat10.x = fract((-u_xlat18.x));
                    u_xlat10.x = u_xlat10.x + 0.5;
                    u_xlat10.x = floor(u_xlat10.x);
                    u_xlat18.xy = fract(u_xlat18.xy);
                    u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
                    u_xlat18.xy = floor(u_xlat18.xy);
                    u_xlat10.x = (-u_xlat18.x) + u_xlat10.x;
                    u_xlat18.x = u_xlat10.x * u_xlat18.y + u_xlat18.x;
                    u_xlat27 = (-u_xlat9) * u_xlat0.x + 1.0;
                    u_xlat10.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat18.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat9 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.zyy + u_xlat18.xxx;
                    u_xlat0.xyz = (u_xlatb1.y) ? u_xlat4.xyz : u_xlat0.xyz;
                    u_xlat2.xyz = (u_xlatb1.x) ? u_xlat3.xyz : u_xlat0.xyz;
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
        SV_Target0 = vec4(0.400000006, 0.400000006, 0.400000006, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = u_xlat16_0.zzz * vs_COLOR0.xyz;
    u_xlat16_34 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_34 = (-u_xlat16_34) + 1.00010002;
    u_xlat16_0.w = sqrt(u_xlat16_34);
    u_xlat16_1 = max(_DefaultSmoothness_HLOD, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyw);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyw);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyw);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat16_34 = _mhyRainNoiseParam1.z * _RainIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16_1) + 1.0;
    SV_Target2.w = u_xlat16_34 * u_xlat16_8 + u_xlat16_1;
    SV_Target1.xyz = u_xlat16_7.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb1.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb1.x) ? 0.0 : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
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
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" }
""
}
}
}
 UsePass "miHoYo/Shadow/ShadowMapPass/LSPSMCULLNONE"
}
Fallback "Nature/Terrain/Diffuse"
}