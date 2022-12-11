//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/MatCapObject" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainTex ("MainTex", 2D) = "white" { }
_NormalTex ("NormalTex", 2D) = "white" { }
_NormalSale ("NormalSale", Float) = 1
_Spec_Color ("Spec_Color", Color) = (1,1,1,1)
_SpecColorScale ("SpecColorScale", Float) = 1
_SpecLight_Scale ("SpecLight_Scale", Float) = 0.7
_SpecLight_Threshold ("SpecLight_Threshold", Float) = 0.5
_FresPower ("FresPower", Float) = 9
_MatCapColor ("MatCapColor", Color) = (1,1,1,1)
_MatCapTex ("MatCapTex", 2D) = "white" { }
_texcoord ("", 2D) = "white" { }
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "MAIN"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 29474
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_3.x = (-u_xlat4.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_3.x>=0.579999983);
#else
    u_xlatb4 = u_xlat16_3.x>=0.579999983;
#endif
    u_xlat16_3.x = (u_xlatb4) ? 1.0 : 0.0;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_7.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_7.x = u_xlat16_7.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_7.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_7.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat2.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat2.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_3.x = (-u_xlat4.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_3.x>=0.579999983);
#else
    u_xlatb4 = u_xlat16_3.x>=0.579999983;
#endif
    u_xlat16_3.x = (u_xlatb4) ? 1.0 : 0.0;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_7.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_7.x = u_xlat16_7.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_7.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_7.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat2.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat2.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_3.x = (-u_xlat4.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_3.x>=0.579999983);
#else
    u_xlatb4 = u_xlat16_3.x>=0.579999983;
#endif
    u_xlat16_3.x = (u_xlatb4) ? 1.0 : 0.0;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_7.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_7.x = u_xlat16_7.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_7.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_7.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat2.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat2.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
mediump vec3 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_3.x = (-u_xlat4.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_3.x>=0.579999983);
#else
    u_xlatb4 = u_xlat16_3.x>=0.579999983;
#endif
    u_xlat16_3.x = (u_xlatb4) ? 1.0 : 0.0;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_7.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_7.x = u_xlat16_7.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_7.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_7.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat2.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat2.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * vec3(u_xlat18) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_9.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat0.x) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _FresPower;
    u_xlat16_5 = exp2(u_xlat16_5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_5>=0.579999983);
#else
    u_xlatb0.x = u_xlat16_5>=0.579999983;
#endif
    u_xlat16_5 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_5;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat10_0.xyz = texture(_MainTex, u_xlat6.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_0.xyz = u_xlat16_9.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * vec3(u_xlat18) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_9.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat0.x) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _FresPower;
    u_xlat16_5 = exp2(u_xlat16_5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_5>=0.579999983);
#else
    u_xlatb0.x = u_xlat16_5>=0.579999983;
#endif
    u_xlat16_5 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_5;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat10_0.xyz = texture(_MainTex, u_xlat6.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_0.xyz = u_xlat16_9.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
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
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * vec3(u_xlat18) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_9.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat0.x) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _FresPower;
    u_xlat16_5 = exp2(u_xlat16_5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_5>=0.579999983);
#else
    u_xlatb0.x = u_xlat16_5>=0.579999983;
#endif
    u_xlat16_5 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_5;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat10_0.xyz = texture(_MainTex, u_xlat6.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_0.xyz = u_xlat16_9.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _MatCapColor;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCapTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_9;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD4.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz * vec3(u_xlat18) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_9.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_3.x = u_xlat16_3.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat0.x) + 1.0;
    u_xlat16_5 = max(u_xlat16_5, 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _FresPower;
    u_xlat16_5 = exp2(u_xlat16_5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_5>=0.579999983);
#else
    u_xlatb0.x = u_xlat16_5>=0.579999983;
#endif
    u_xlat16_5 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_5;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat10_0.xyz = texture(_MainTex, u_xlat6.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat16_0.xyz = u_xlat16_9.xyz * u_xlat16_3.xxx + u_xlat16_0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_MatCapTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 73526
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	int _HasLastPositionData;
uniform 	float _MotionVectorDepthBias;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 1.0;
    u_xlat1 = (_HasLastPositionData != 0) ? u_xlat1 : in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat2 = hlslcc_mtx4x4_PreviousM[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_PreviousM[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_PreviousM[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat2 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat0.x * u_xlat0.w + u_xlat0.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	int _ForceNoMotion;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
ivec2 u_xlati0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat16_1.x = (_ForceNoMotion != 0) ? 1.0 : 0.0;
    u_xlat16_1.xy = u_xlat16_1.xx * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlati0.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_1.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = ivec2(uvec2(lessThan(u_xlat16_1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat16_2.xy = sqrt(abs(u_xlat16_1.xy));
    u_xlati0.xy = (-u_xlati0.xy) + u_xlati6.xy;
    u_xlat0.xy = vec2(u_xlati0.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(1.0, 1.0);
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}