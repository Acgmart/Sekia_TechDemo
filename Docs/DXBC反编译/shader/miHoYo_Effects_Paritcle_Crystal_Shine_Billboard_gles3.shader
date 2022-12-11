//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Paritcle_Crystal_Shine_Billboard" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainTex ("MainTex", 2D) = "white" { }
_MainTexChannleNum ("MainTexChannleNum", Range(0, 4)) = 1
_MainTexChannelScale ("MainTexChannelScale", Float) = 1
_ShineColor ("ShineColor", Color) = (1,1,1,1)
_ShinePlus ("ShinePlus", Float) = 1
_ShineAffactMask ("ShineAffactMask", Range(0, 1)) = 0
_ViewUVOffset ("ViewUVOffset", Float) = 0
_USpeed ("USpeed", Float) = 0
_VSpeed ("VSpeed", Float) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskTexChannelNum ("MaskTexChannelNum", Range(0, 4)) = 1
_MaskScale ("MaskScale", Float) = 1
_texcoord ("", 2D) = "white" { }
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
  GpuProgramID 50062
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat3.y = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat1.y = 1.0;
    u_xlat3.x = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat3.z = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[3]);
    u_xlat0.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat1.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.xxxx + u_xlat0;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _ShineAffactMask * u_xlat16_1.x + 1.0;
    u_xlat16_2 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_5 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_5;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat4.x = u_xlat16_4.x * u_xlat2.w;
    u_xlat4.x = u_xlat16_1.x * u_xlat4.x;
    SV_Target0.w = u_xlat4.x;
    u_xlat16_1.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat3.y = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1]);
    u_xlat3.x = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0]);
    u_xlat3.z = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3]);
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1]);
    u_xlat2 = u_xlat0.xxxx * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0]);
    u_xlat8 = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2]);
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * vec4(u_xlat8) + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _ShineAffactMask * u_xlat16_1.x + 1.0;
    u_xlat16_2 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_5 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_5;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat4.x = u_xlat16_4.x * u_xlat2.w;
    u_xlat4.x = u_xlat16_1.x * u_xlat4.x;
    SV_Target0.w = u_xlat4.x;
    u_xlat16_1.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat3.y = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat1.y = 1.0;
    u_xlat3.x = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat3.z = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[3]);
    u_xlat0.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat1.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.xxxx + u_xlat0;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat11 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD5.xyz;
    u_xlat11 = dot(u_xlat2.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_3.xy = vec2(u_xlat11) * vec2(_ViewUVOffset) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_3 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = u_xlat16_1.x + -1.0;
    u_xlat16_9 = _ShineAffactMask * u_xlat16_9 + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_4 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat0.w;
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat3.y = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1]);
    u_xlat3.x = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0]);
    u_xlat3.z = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3]);
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1]);
    u_xlat2 = u_xlat0.xxxx * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0]);
    u_xlat8 = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2]);
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * vec4(u_xlat8) + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat11 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD5.xyz;
    u_xlat11 = dot(u_xlat2.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_3.xy = vec2(u_xlat11) * vec2(_ViewUVOffset) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_3 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = u_xlat16_1.x + -1.0;
    u_xlat16_9 = _ShineAffactMask * u_xlat16_9 + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_4 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat0.w;
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat3.y = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat1.y = 1.0;
    u_xlat3.x = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat3.z = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[3]);
    u_xlat0.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat1.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.xxxx + u_xlat0;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _ShineAffactMask * u_xlat16_1.x + 1.0;
    u_xlat16_2 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_5 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_5;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat4.x = u_xlat16_4.x * u_xlat2.w;
    u_xlat4.x = u_xlat16_1.x * u_xlat4.x;
    SV_Target0.w = u_xlat4.x;
    u_xlat16_1.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat3.y = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1]);
    u_xlat3.x = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0]);
    u_xlat3.z = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3]);
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1]);
    u_xlat2 = u_xlat0.xxxx * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0]);
    u_xlat8 = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2]);
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * vec4(u_xlat8) + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _ShineAffactMask * u_xlat16_1.x + 1.0;
    u_xlat16_2 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_3 = texture(_MaskTex, u_xlat4.xy);
    u_xlat16_4.xy = u_xlat16_2.xy * u_xlat10_3.xy;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_3.w * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_5 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_5;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat4.x = u_xlat16_4.x * u_xlat2.w;
    u_xlat4.x = u_xlat16_1.x * u_xlat4.x;
    SV_Target0.w = u_xlat4.x;
    u_xlat16_1.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat3.y = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat1.y = 1.0;
    u_xlat3.x = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat3.z = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[3]);
    u_xlat0.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat1.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.xxxx + u_xlat0;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat11 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD5.xyz;
    u_xlat11 = dot(u_xlat2.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_3.xy = vec2(u_xlat11) * vec2(_ViewUVOffset) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_3 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = u_xlat16_1.x + -1.0;
    u_xlat16_9 = _ShineAffactMask * u_xlat16_9 + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_4 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat0.w;
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat3.y = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1]);
    u_xlat3.x = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0]);
    u_xlat3.z = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3]);
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1]);
    u_xlat2 = u_xlat0.xxxx * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0]);
    u_xlat8 = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2]);
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * vec4(u_xlat8) + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _ShineColor;
uniform 	mediump float _ShinePlus;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat11 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD5.xyz;
    u_xlat11 = dot(u_xlat2.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_3.xy = vec2(u_xlat11) * vec2(_ViewUVOffset) + u_xlat1.xy;
    u_xlat1.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_3.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_3.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _ShineColor.xyz * vec3(_ShinePlus);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_3 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = u_xlat16_1.x + -1.0;
    u_xlat16_9 = _ShineAffactMask * u_xlat16_9 + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_4 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat0.w;
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
  GpuProgramID 70070
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat3.y = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat1.y = 1.0;
    u_xlat3.x = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat3.z = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[3]);
    u_xlat0.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat1.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.xxxx + u_xlat0;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat3.y = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1]);
    u_xlat3.x = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0]);
    u_xlat3.z = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3]);
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1]);
    u_xlat2 = u_xlat0.xxxx * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0]);
    u_xlat8 = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2]);
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * vec4(u_xlat8) + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
  GpuProgramID 185986
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat3.y = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat1.y = 1.0;
    u_xlat3.x = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat3.z = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, hlslcc_mtx4x4unity_ObjectToWorld[3]);
    u_xlat0.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat1.x = dot(u_xlat1, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD6.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec2 u_xlat10;
ivec2 u_xlati10;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _ShineAffactMask * u_xlat16_1.x + 1.0;
    u_xlat16_0 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat2.xy);
    u_xlat16_2.xy = u_xlat16_0.xy * u_xlat10_2.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_0.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_0.w + u_xlat16_2.x;
    u_xlat16_5 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_2.x = u_xlat16_5 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat2.x = u_xlat16_2.x * u_xlat6;
    u_xlat16_1.x = u_xlat2.x * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb2 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat2.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat2.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat2.xy = sqrt(abs(u_xlat2.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
    u_xlat10.xy = vec2(u_xlati10.xy);
    u_xlat2.xy = u_xlat10.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat2.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat3.y = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1]);
    u_xlat3.x = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0]);
    u_xlat3.z = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2]);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.w = dot(in_POSITION0, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3]);
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1]);
    u_xlat2 = u_xlat0.xxxx * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0.x = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0]);
    u_xlat8 = dot(u_xlat1, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2]);
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * vec4(u_xlat8) + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
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
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexChannelNum;
uniform 	mediump float _MaskScale;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MainTexChannelScale;
uniform 	mediump float _ShineAffactMask;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec2 u_xlat10;
ivec2 u_xlati10;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _MainTexChannelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _ShineAffactMask * u_xlat16_1.x + 1.0;
    u_xlat16_0 = (-vec4(_MaskTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat2.xy);
    u_xlat16_2.xy = u_xlat16_0.xy * u_xlat10_2.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_0.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_0.w + u_xlat16_2.x;
    u_xlat16_5 = min(abs(_MaskTexChannelNum), 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_2.x = u_xlat16_5 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat2.x = u_xlat16_2.x * u_xlat6;
    u_xlat16_1.x = u_xlat2.x * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb2 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat2.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat2.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat2.xy = sqrt(abs(u_xlat2.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati3.xy;
    u_xlat10.xy = vec2(u_xlati10.xy);
    u_xlat2.xy = u_xlat10.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat2.xy;
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