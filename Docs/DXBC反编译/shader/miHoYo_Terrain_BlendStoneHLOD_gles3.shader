//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Terrain/BlendStoneHLOD" {
Properties {
_IndirectSpecular ("Indirect Specular", Range(0, 20)) = 1
[Toggle(_TintColor_ON)] _TintColor_ON ("Use Tint Color", Float) = 0
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_SSAO_Intensity ("SSAO Intensity", Range(0, 1)) = 0.35
_Terrain_Smoothness ("Terrain_Smoothness", Range(0, 2)) = 1
_Terrain_Specular ("Terrain_Specular", Range(0, 3)) = 0.8
_Shininess ("Shininess", Range(-1, 1)) = -0.96
_MainTex ("Base (RGB)", 2D) = "white" { }
_BumpMap ("Normalmap", 2D) = "bump" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 40519
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat9;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat16_0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb3 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat16_1.xyz : u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat9;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat16_0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb3 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb3)) ? u_xlat16_1.xyz : u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
  GpuProgramID 124174
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
  GpuProgramID 191653
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * _TintColor.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? u_xlat16_1.xyz : u_xlat3.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_10 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_2.x);
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target1.w = _SSAO_Intensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    u_xlat16_1.x = _Terrain_Smoothness * _Shininess;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    SV_Target2.w = min(u_xlat16_1.x, 0.5);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec3 u_xlat11;
vec3 u_xlat12;
vec3 u_xlat13;
bvec3 u_xlatb13;
vec2 u_xlat20;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat23;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat33;
mediump float u_xlat16_37;
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
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat20.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat20.x = dot(u_xlat20.xy, u_xlat20.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat20.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat10 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat10 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb32)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat32 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat32 = max(u_xlat32, u_xlat4.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat13.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat33 = sqrt(u_xlat32);
                u_xlat4.x = sqrt(u_xlat13.x);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat3.z);
                u_xlat13.x = inversesqrt(u_xlat13.x);
                u_xlat3.x = u_xlat13.x * abs(u_xlat3.x);
                u_xlat32 = u_xlat32 * u_xlat3.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat3.x = u_xlat33 * u_xlat4.x;
                u_xlat13.x = u_xlat32 * u_xlat3.x;
                u_xlat23.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat23.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat23.xy = fract(u_xlat23.xy);
                u_xlat23.xy = u_xlat23.xy + vec2(0.5, 0.5);
                u_xlat23.xy = floor(u_xlat23.xy);
                u_xlat4.x = (-u_xlat23.x) + u_xlat4.x;
                u_xlat23.x = u_xlat4.x * u_xlat23.y + u_xlat23.x;
                u_xlat33 = (-u_xlat3.x) * u_xlat32 + 1.0;
                u_xlat4.xyz = (-u_xlat23.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat23.xxx;
                u_xlatb13.xz = lessThan(u_xlat13.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat23.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat3.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat32) * u_xlat4.zyy + u_xlat23.xxx;
                u_xlat3.xzw = (u_xlatb13.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb13.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat23.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat23.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat23.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat23.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat13.x = sqrt(u_xlat32);
                    u_xlat23.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat3.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat23.x * u_xlat13.x;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat21.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat3.x = (-u_xlat21.x) + u_xlat3.x;
                    u_xlat21.x = u_xlat3.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat31 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat21.x = max(u_xlat31, u_xlat21.x);
                    u_xlat21.x = log2(u_xlat21.x);
                    u_xlat21.x = u_xlat21.x * 0.5;
                    u_xlat21.x = max(u_xlat21.x, 0.0);
                    u_xlat21.x = u_xlat21.x + 1.0;
                    u_xlat31 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat31) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat31);
                    u_xlat1.xy = u_xlat1.xy / u_xlat21.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat21.xx;
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat10 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat21.x = sqrt(u_xlat11.x);
                    u_xlat31 = sqrt(u_xlat10);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat0.x = u_xlat10 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat10 = u_xlat31 * u_xlat21.x;
                    u_xlat1.x = u_xlat0.x * u_xlat10;
                    u_xlat20.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat11.x = fract((-u_xlat20.x));
                    u_xlat11.x = u_xlat11.x + 0.5;
                    u_xlat11.x = floor(u_xlat11.x);
                    u_xlat20.xy = fract(u_xlat20.xy);
                    u_xlat20.xy = u_xlat20.xy + vec2(0.5, 0.5);
                    u_xlat20.xy = floor(u_xlat20.xy);
                    u_xlat11.x = (-u_xlat20.x) + u_xlat11.x;
                    u_xlat20.x = u_xlat11.x * u_xlat20.y + u_xlat20.x;
                    u_xlat30 = (-u_xlat10) * u_xlat0.x + 1.0;
                    u_xlat11.xyz = (-u_xlat20.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat11.xyz + u_xlat20.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat20.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat10 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.zyy + u_xlat20.xxx;
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
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyz = u_xlat0.xyz * _TintColor.xyz;
    u_xlat16_7.xyz = (bool(u_xlatb30)) ? u_xlat16_7.xyz : u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_37 = _Terrain_Smoothness * _Shininess;
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    SV_Target2.w = min(u_xlat16_37, 0.5);
    u_xlat16_9.xyz = u_xlat16_7.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_9.z, u_xlat16_9.y);
    u_xlat16_37 = max(u_xlat16_37, u_xlat16_9.x);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : u_xlat16_9.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_9.xy;
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec3 u_xlat11;
vec3 u_xlat12;
vec3 u_xlat13;
bvec3 u_xlatb13;
vec2 u_xlat20;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat23;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat33;
mediump float u_xlat16_37;
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
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat20.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat20.x = dot(u_xlat20.xy, u_xlat20.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat20.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat10 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat10 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb32)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat32 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat32 = max(u_xlat32, u_xlat4.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat13.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat33 = sqrt(u_xlat32);
                u_xlat4.x = sqrt(u_xlat13.x);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat3.z);
                u_xlat13.x = inversesqrt(u_xlat13.x);
                u_xlat3.x = u_xlat13.x * abs(u_xlat3.x);
                u_xlat32 = u_xlat32 * u_xlat3.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat3.x = u_xlat33 * u_xlat4.x;
                u_xlat13.x = u_xlat32 * u_xlat3.x;
                u_xlat23.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat23.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat23.xy = fract(u_xlat23.xy);
                u_xlat23.xy = u_xlat23.xy + vec2(0.5, 0.5);
                u_xlat23.xy = floor(u_xlat23.xy);
                u_xlat4.x = (-u_xlat23.x) + u_xlat4.x;
                u_xlat23.x = u_xlat4.x * u_xlat23.y + u_xlat23.x;
                u_xlat33 = (-u_xlat3.x) * u_xlat32 + 1.0;
                u_xlat4.xyz = (-u_xlat23.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat23.xxx;
                u_xlatb13.xz = lessThan(u_xlat13.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat23.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat3.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat32) * u_xlat4.zyy + u_xlat23.xxx;
                u_xlat3.xzw = (u_xlatb13.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb13.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat23.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat23.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat23.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat23.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat13.x = sqrt(u_xlat32);
                    u_xlat23.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat3.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat23.x * u_xlat13.x;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat21.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat3.x = (-u_xlat21.x) + u_xlat3.x;
                    u_xlat21.x = u_xlat3.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat31 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat21.x = max(u_xlat31, u_xlat21.x);
                    u_xlat21.x = log2(u_xlat21.x);
                    u_xlat21.x = u_xlat21.x * 0.5;
                    u_xlat21.x = max(u_xlat21.x, 0.0);
                    u_xlat21.x = u_xlat21.x + 1.0;
                    u_xlat31 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat31) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat31);
                    u_xlat1.xy = u_xlat1.xy / u_xlat21.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat21.xx;
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat10 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat21.x = sqrt(u_xlat11.x);
                    u_xlat31 = sqrt(u_xlat10);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat0.x = u_xlat10 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat10 = u_xlat31 * u_xlat21.x;
                    u_xlat1.x = u_xlat0.x * u_xlat10;
                    u_xlat20.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat11.x = fract((-u_xlat20.x));
                    u_xlat11.x = u_xlat11.x + 0.5;
                    u_xlat11.x = floor(u_xlat11.x);
                    u_xlat20.xy = fract(u_xlat20.xy);
                    u_xlat20.xy = u_xlat20.xy + vec2(0.5, 0.5);
                    u_xlat20.xy = floor(u_xlat20.xy);
                    u_xlat11.x = (-u_xlat20.x) + u_xlat11.x;
                    u_xlat20.x = u_xlat11.x * u_xlat20.y + u_xlat20.x;
                    u_xlat30 = (-u_xlat10) * u_xlat0.x + 1.0;
                    u_xlat11.xyz = (-u_xlat20.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat11.xyz + u_xlat20.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat20.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat10 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.zyy + u_xlat20.xxx;
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
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyz = u_xlat0.xyz * _TintColor.xyz;
    u_xlat16_7.xyz = (bool(u_xlatb30)) ? u_xlat16_7.xyz : u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_37 = _Terrain_Smoothness * _Shininess;
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    SV_Target2.w = min(u_xlat16_37, 0.5);
    u_xlat16_9.xyz = u_xlat16_7.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_9.z, u_xlat16_9.y);
    u_xlat16_37 = max(u_xlat16_37, u_xlat16_9.x);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : u_xlat16_9.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_9.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec3 u_xlat11;
vec3 u_xlat12;
vec3 u_xlat13;
bvec3 u_xlatb13;
vec2 u_xlat20;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat23;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat33;
mediump float u_xlat16_37;
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
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat20.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat20.x = dot(u_xlat20.xy, u_xlat20.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat20.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat10 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat10 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb32)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat32 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat32 = max(u_xlat32, u_xlat4.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat13.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat33 = sqrt(u_xlat32);
                u_xlat4.x = sqrt(u_xlat13.x);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat3.z);
                u_xlat13.x = inversesqrt(u_xlat13.x);
                u_xlat3.x = u_xlat13.x * abs(u_xlat3.x);
                u_xlat32 = u_xlat32 * u_xlat3.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat3.x = u_xlat33 * u_xlat4.x;
                u_xlat13.x = u_xlat32 * u_xlat3.x;
                u_xlat23.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat23.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat23.xy = fract(u_xlat23.xy);
                u_xlat23.xy = u_xlat23.xy + vec2(0.5, 0.5);
                u_xlat23.xy = floor(u_xlat23.xy);
                u_xlat4.x = (-u_xlat23.x) + u_xlat4.x;
                u_xlat23.x = u_xlat4.x * u_xlat23.y + u_xlat23.x;
                u_xlat33 = (-u_xlat3.x) * u_xlat32 + 1.0;
                u_xlat4.xyz = (-u_xlat23.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat23.xxx;
                u_xlatb13.xz = lessThan(u_xlat13.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat23.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat3.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat32) * u_xlat4.zyy + u_xlat23.xxx;
                u_xlat3.xzw = (u_xlatb13.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb13.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat23.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat23.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat23.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat23.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat13.x = sqrt(u_xlat32);
                    u_xlat23.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat3.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat23.x * u_xlat13.x;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat21.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat3.x = (-u_xlat21.x) + u_xlat3.x;
                    u_xlat21.x = u_xlat3.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat31 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat21.x = max(u_xlat31, u_xlat21.x);
                    u_xlat21.x = log2(u_xlat21.x);
                    u_xlat21.x = u_xlat21.x * 0.5;
                    u_xlat21.x = max(u_xlat21.x, 0.0);
                    u_xlat21.x = u_xlat21.x + 1.0;
                    u_xlat31 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat31) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat31);
                    u_xlat1.xy = u_xlat1.xy / u_xlat21.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat21.xx;
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat10 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat21.x = sqrt(u_xlat11.x);
                    u_xlat31 = sqrt(u_xlat10);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat0.x = u_xlat10 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat10 = u_xlat31 * u_xlat21.x;
                    u_xlat1.x = u_xlat0.x * u_xlat10;
                    u_xlat20.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat11.x = fract((-u_xlat20.x));
                    u_xlat11.x = u_xlat11.x + 0.5;
                    u_xlat11.x = floor(u_xlat11.x);
                    u_xlat20.xy = fract(u_xlat20.xy);
                    u_xlat20.xy = u_xlat20.xy + vec2(0.5, 0.5);
                    u_xlat20.xy = floor(u_xlat20.xy);
                    u_xlat11.x = (-u_xlat20.x) + u_xlat11.x;
                    u_xlat20.x = u_xlat11.x * u_xlat20.y + u_xlat20.x;
                    u_xlat30 = (-u_xlat10) * u_xlat0.x + 1.0;
                    u_xlat11.xyz = (-u_xlat20.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat11.xyz + u_xlat20.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat20.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat10 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.zyy + u_xlat20.xxx;
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
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyz = u_xlat0.xyz * _TintColor.xyz;
    u_xlat16_7.xyz = (bool(u_xlatb30)) ? u_xlat16_7.xyz : u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_37 = _Terrain_Smoothness * _Shininess;
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    SV_Target2.w = min(u_xlat16_37, 0.5);
    u_xlat16_9.xyz = u_xlat16_7.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_9.z, u_xlat16_9.y);
    u_xlat16_37 = max(u_xlat16_37, u_xlat16_9.x);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : u_xlat16_9.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_9.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _UseTintColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _SSAO_Intensity;
uniform 	mediump float _Terrain_Smoothness;
uniform 	mediump float _Terrain_Specular;
uniform 	mediump float _Shininess;
uniform 	vec4 _GrassDiffuse_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _BumpMap_TexelSize;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec3 u_xlat11;
vec3 u_xlat12;
vec3 u_xlat13;
bvec3 u_xlatb13;
vec2 u_xlat20;
vec2 u_xlat21;
float u_xlat22;
vec2 u_xlat23;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
float u_xlat32;
bool u_xlatb32;
float u_xlat33;
mediump float u_xlat16_37;
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
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
        u_xlat20.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat20.x = dot(u_xlat20.xy, u_xlat20.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat20.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat10 = max(_GrassDiffuse_TexelSize.w, _GrassDiffuse_TexelSize.z);
        u_xlat0.x = u_xlat10 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb10 = !!(256.0<u_xlat0.x);
#else
        u_xlatb10 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb10)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
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
            u_xlat3.xy = vec2(_MainTex_ST.x * _BumpMap_TexelSize.z, _MainTex_ST.y * _BumpMap_TexelSize.w);
            u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
            u_xlatb32 = u_xlatb3.y || u_xlatb3.x;
            u_xlat0.xy = _BumpMap_TexelSize.zw;
            u_xlat0 = (bool(u_xlatb32)) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb32 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb32){
                u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                u_xlat3.zw = dFdx(u_xlat3.xy);
                u_xlat3.xy = dFdy(u_xlat3.xy);
                u_xlat32 = dot(u_xlat3.zw, u_xlat3.zw);
                u_xlat4.x = dot(u_xlat3.xy, u_xlat3.xy);
                u_xlat32 = max(u_xlat32, u_xlat4.x);
                u_xlat32 = log2(u_xlat32);
                u_xlat32 = u_xlat32 * 0.5;
                u_xlat32 = max(u_xlat32, 0.0);
                u_xlat32 = u_xlat32 + 1.0;
                u_xlat4.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                u_xlat3 = u_xlat3 * u_xlat4.xxxx;
                u_xlat3 = u_xlat3 / vec4(u_xlat32);
                u_xlat32 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                u_xlat13.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                u_xlat33 = sqrt(u_xlat32);
                u_xlat4.x = sqrt(u_xlat13.x);
                u_xlat32 = inversesqrt(u_xlat32);
                u_xlat32 = u_xlat32 * abs(u_xlat3.z);
                u_xlat13.x = inversesqrt(u_xlat13.x);
                u_xlat3.x = u_xlat13.x * abs(u_xlat3.x);
                u_xlat32 = u_xlat32 * u_xlat3.x;
                u_xlat32 = (-u_xlat32) * u_xlat32 + 1.0;
                u_xlat32 = sqrt(u_xlat32);
                u_xlat3.x = u_xlat33 * u_xlat4.x;
                u_xlat13.x = u_xlat32 * u_xlat3.x;
                u_xlat23.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                u_xlat4.x = fract((-u_xlat23.x));
                u_xlat4.x = u_xlat4.x + 0.5;
                u_xlat4.x = floor(u_xlat4.x);
                u_xlat23.xy = fract(u_xlat23.xy);
                u_xlat23.xy = u_xlat23.xy + vec2(0.5, 0.5);
                u_xlat23.xy = floor(u_xlat23.xy);
                u_xlat4.x = (-u_xlat23.x) + u_xlat4.x;
                u_xlat23.x = u_xlat4.x * u_xlat23.y + u_xlat23.x;
                u_xlat33 = (-u_xlat3.x) * u_xlat32 + 1.0;
                u_xlat4.xyz = (-u_xlat23.xxx) + vec3(0.5, 0.0, 1.0);
                u_xlat5.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat23.xxx;
                u_xlatb13.xz = lessThan(u_xlat13.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                u_xlat6.xyz = u_xlat23.xxx * vec3(0.0, 1.0, 0.0);
                u_xlat32 = u_xlat3.x * u_xlat32 + -4.0;
                u_xlat32 = exp2(u_xlat32);
                u_xlat32 = u_xlat32 + -0.25;
#ifdef UNITY_ADRENO_ES3
                u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
                u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
                u_xlat4.xyz = vec3(u_xlat32) * u_xlat4.zyy + u_xlat23.xxx;
                u_xlat3.xzw = (u_xlatb13.z) ? u_xlat6.xyz : u_xlat4.xyz;
                u_xlat2.xyz = (u_xlatb13.x) ? u_xlat5.xyz : u_xlat3.xzw;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb32 = !!(u_xlat1.x>=u_xlat0.x);
#else
                u_xlatb32 = u_xlat1.x>=u_xlat0.x;
#endif
                if(u_xlatb32){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat32 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat32 = max(u_xlat32, u_xlat23.x);
                    u_xlat32 = log2(u_xlat32);
                    u_xlat32 = u_xlat32 * 0.5;
                    u_xlat32 = max(u_xlat32, 0.0);
                    u_xlat32 = u_xlat32 + 1.0;
                    u_xlat23.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = u_xlat23.xx * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * u_xlat23.xx;
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat32);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat32);
                    u_xlat32 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat13.x = sqrt(u_xlat32);
                    u_xlat23.x = sqrt(u_xlat11.x);
                    u_xlat32 = inversesqrt(u_xlat32);
                    u_xlat32 = u_xlat32 * abs(u_xlat3.x);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x * u_xlat32;
                    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
                    u_xlat1.x = sqrt(u_xlat1.x);
                    u_xlat11.x = u_xlat23.x * u_xlat13.x;
                    u_xlat32 = u_xlat1.x * u_xlat11.x;
                    u_xlat21.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat3.x = fract((-u_xlat21.x));
                    u_xlat3.x = u_xlat3.x + 0.5;
                    u_xlat3.x = floor(u_xlat3.x);
                    u_xlat21.xy = fract(u_xlat21.xy);
                    u_xlat21.xy = u_xlat21.xy + vec2(0.5, 0.5);
                    u_xlat21.xy = floor(u_xlat21.xy);
                    u_xlat3.x = (-u_xlat21.x) + u_xlat3.x;
                    u_xlat21.x = u_xlat3.x * u_xlat21.y + u_xlat21.x;
                    u_xlat31 = (-u_xlat11.x) * u_xlat1.x + 1.0;
                    u_xlat3.xyz = (-u_xlat21.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat31) * u_xlat3.xyz + u_xlat21.xxx;
                    u_xlatb3.xw = lessThan(vec4(u_xlat32), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                    u_xlat5.xyz = u_xlat21.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat1.x = u_xlat11.x * u_xlat1.x + -4.0;
                    u_xlat1.x = exp2(u_xlat1.x);
                    u_xlat1.x = u_xlat1.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
                    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
                    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.zyy + u_xlat21.xxx;
                    u_xlat1.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat1.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat4.xyz : u_xlat1.xyz;
                } else {
                    u_xlat0.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat1.xy = dFdx(u_xlat0.xy);
                    u_xlat0.xy = dFdy(u_xlat0.xy);
                    u_xlat21.x = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat31 = dot(u_xlat0.xy, u_xlat0.xy);
                    u_xlat21.x = max(u_xlat31, u_xlat21.x);
                    u_xlat21.x = log2(u_xlat21.x);
                    u_xlat21.x = u_xlat21.x * 0.5;
                    u_xlat21.x = max(u_xlat21.x, 0.0);
                    u_xlat21.x = u_xlat21.x + 1.0;
                    u_xlat31 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat1.xy = vec2(u_xlat31) * u_xlat1.xy;
                    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat31);
                    u_xlat1.xy = u_xlat1.xy / u_xlat21.xx;
                    u_xlat0.xy = u_xlat0.xy / u_xlat21.xx;
                    u_xlat11.x = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat10 = dot(abs(u_xlat0.xy), abs(u_xlat0.xy));
                    u_xlat21.x = sqrt(u_xlat11.x);
                    u_xlat31 = sqrt(u_xlat10);
                    u_xlat11.x = inversesqrt(u_xlat11.x);
                    u_xlat1.x = u_xlat11.x * abs(u_xlat1.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat0.x = u_xlat10 * abs(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x * u_xlat1.x;
                    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
                    u_xlat0.x = sqrt(u_xlat0.x);
                    u_xlat10 = u_xlat31 * u_xlat21.x;
                    u_xlat1.x = u_xlat0.x * u_xlat10;
                    u_xlat20.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat11.x = fract((-u_xlat20.x));
                    u_xlat11.x = u_xlat11.x + 0.5;
                    u_xlat11.x = floor(u_xlat11.x);
                    u_xlat20.xy = fract(u_xlat20.xy);
                    u_xlat20.xy = u_xlat20.xy + vec2(0.5, 0.5);
                    u_xlat20.xy = floor(u_xlat20.xy);
                    u_xlat11.x = (-u_xlat20.x) + u_xlat11.x;
                    u_xlat20.x = u_xlat11.x * u_xlat20.y + u_xlat20.x;
                    u_xlat30 = (-u_xlat10) * u_xlat0.x + 1.0;
                    u_xlat11.xyz = (-u_xlat20.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat3.xyz = vec3(u_xlat30) * u_xlat11.xyz + u_xlat20.xxx;
                    u_xlatb1.xy = lessThan(u_xlat1.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                    u_xlat4.xyz = u_xlat20.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat0.x = u_xlat10 * u_xlat0.x + -4.0;
                    u_xlat0.x = exp2(u_xlat0.x);
                    u_xlat0.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
                    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
                    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.zyy + u_xlat20.xxx;
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
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor));
#else
    u_xlatb30 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseTintColor);
#endif
    u_xlat16_7.xyz = u_xlat0.xyz * _TintColor.xyz;
    u_xlat16_7.xyz = (bool(u_xlatb30)) ? u_xlat16_7.xyz : u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_37 = _Terrain_Smoothness * _Shininess;
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    SV_Target2.w = min(u_xlat16_37, 0.5);
    u_xlat16_9.xyz = u_xlat16_7.xyz * vec3(vec3(_Terrain_Specular, _Terrain_Specular, _Terrain_Specular));
    u_xlat16_0.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_9.z, u_xlat16_9.y);
    u_xlat16_37 = max(u_xlat16_37, u_xlat16_9.x);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    SV_Target1.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : u_xlat16_9.z;
    SV_Target0.w = 0.0;
    SV_Target1.w = _SSAO_Intensity;
    SV_Target2.xy = u_xlat16_9.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
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
Keywords { "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "LINE_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
 UsePass "miHoYo/Shadow/ShadowMapPass/LSPSMCULLNONE"
}
Fallback "Nature/Terrain/Diffuse"
}