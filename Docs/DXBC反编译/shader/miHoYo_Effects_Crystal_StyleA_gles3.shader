//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Crystal_StyleA" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorScale ("ColorScale", Float) = 1
_MainTex ("MainTex", 2D) = "white" { }
_MainTexChannleNum ("MainTexChannleNum", Range(0, 4)) = 1
_ViewUVOffset ("ViewUVOffset", Float) = 0
_USpeed ("USpeed", Float) = 0
_VSpeed ("VSpeed", Float) = 0
_DistortTex ("DistortTex", 2D) = "white" { }
_DistortChannelNum ("DistortChannelNum", Range(0, 4)) = 1
_DistortUSpeed ("DistortUSpeed", Float) = 0
_DistortVSpeed ("DistortVSpeed", Float) = 0
_DistortOffsetScale ("DistortOffsetScale", Float) = 0
_ColorOffset ("ColorOffset", Range(0, 1)) = 0
_ColorOffestThreshold ("ColorOffestThreshold", Vector) = (0.1,0.1,0,0)
_DistortMask ("DistortMask", Range(0, 1)) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskChannelNum ("MaskChannelNum", Range(0, 4)) = 1
_MaskScale ("MaskScale", Float) = 1
_MaskColorPlus ("MaskColorPlus", Float) = 0
_MaskVSpeed ("MaskVSpeed", Float) = 0
_MaskUSpeed ("MaskUSpeed", Float) = 0
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
  GpuProgramID 18169
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
lowp vec4 u_xlat10_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
bool u_xlatb7;
mediump vec3 u_xlat16_11;
vec2 u_xlat14;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat7.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD5.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, vs_TEXCOORD6.xyz);
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat7.xx * vec2(_ViewUVOffset) + u_xlat14.xy;
    u_xlat7.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_21 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_21 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_21;
    u_xlat7.z = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_21;
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat7.xy);
    u_xlat10_5 = texture(_MainTex, u_xlat16_11.xy);
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat7.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.yz = u_xlat7.xz + u_xlat16_4.xx;
    u_xlat16_11.xyz = (-u_xlat10_5.xyz) + u_xlat3.yyy;
    u_xlat16_6 = ceil(_ColorOffset);
    u_xlat16_11.xyz = vec3(u_xlat16_6) * u_xlat16_11.xyz + u_xlat10_5.xyz;
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb7 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_23 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat7.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat7.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_0.x + u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_23 * _MaskColorPlus + _ColorScale;
    SV_Target0.w = u_xlat16_23;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
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
float u_xlat0;
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
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
lowp vec4 u_xlat10_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
bool u_xlatb7;
mediump vec3 u_xlat16_11;
vec2 u_xlat14;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat7.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD5.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, vs_TEXCOORD6.xyz);
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat7.xx * vec2(_ViewUVOffset) + u_xlat14.xy;
    u_xlat7.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_21 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_21 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_21;
    u_xlat7.z = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_21;
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat7.xy);
    u_xlat10_5 = texture(_MainTex, u_xlat16_11.xy);
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat7.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.yz = u_xlat7.xz + u_xlat16_4.xx;
    u_xlat16_11.xyz = (-u_xlat10_5.xyz) + u_xlat3.yyy;
    u_xlat16_6 = ceil(_ColorOffset);
    u_xlat16_11.xyz = vec3(u_xlat16_6) * u_xlat16_11.xyz + u_xlat10_5.xyz;
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb7 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_23 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat7.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat7.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_0.x + u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_23 * _MaskColorPlus + _ColorScale;
    SV_Target0.w = u_xlat16_23;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
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
float u_xlat6;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(u_xlat3.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_1.xy = vec2(u_xlat18) * vec2(_ViewUVOffset) + u_xlat6.xy;
    u_xlat6.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_18 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_18 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_18;
    u_xlat16_18 = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_18;
    u_xlat3.y = u_xlat16_4.x + u_xlat16_18;
    u_xlat16_10.x = ceil(_ColorOffset);
    u_xlat16_5.xyz = (-u_xlat10_1.xyz) + u_xlat3.yyy;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_5.xyz + u_xlat10_1.xyz;
    u_xlat10_1 = texture(_MainTex, u_xlat6.xy);
    u_xlat16_5.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_5 = texture(_MainTex, u_xlat16_5.xy);
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.z = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_10.xyz);
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat6.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat6.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_20 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_20 + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb6 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_20 = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_20 = u_xlat16_20 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_0.x + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_20 * _MaskColorPlus + _ColorScale;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat16_20;
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
float u_xlat0;
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
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(u_xlat3.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_1.xy = vec2(u_xlat18) * vec2(_ViewUVOffset) + u_xlat6.xy;
    u_xlat6.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_18 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_18 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_18;
    u_xlat16_18 = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_18;
    u_xlat3.y = u_xlat16_4.x + u_xlat16_18;
    u_xlat16_10.x = ceil(_ColorOffset);
    u_xlat16_5.xyz = (-u_xlat10_1.xyz) + u_xlat3.yyy;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_5.xyz + u_xlat10_1.xyz;
    u_xlat10_1 = texture(_MainTex, u_xlat6.xy);
    u_xlat16_5.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_5 = texture(_MainTex, u_xlat16_5.xy);
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.z = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_10.xyz);
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat6.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat6.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_20 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_20 + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb6 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_20 = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_20 = u_xlat16_20 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_0.x + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_20 * _MaskColorPlus + _ColorScale;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat16_20;
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
float u_xlat6;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
lowp vec4 u_xlat10_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
bool u_xlatb7;
mediump vec3 u_xlat16_11;
vec2 u_xlat14;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat7.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD5.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, vs_TEXCOORD6.xyz);
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat7.xx * vec2(_ViewUVOffset) + u_xlat14.xy;
    u_xlat7.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_21 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_21 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_21;
    u_xlat7.z = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_21;
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat7.xy);
    u_xlat10_5 = texture(_MainTex, u_xlat16_11.xy);
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat7.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.yz = u_xlat7.xz + u_xlat16_4.xx;
    u_xlat16_11.xyz = (-u_xlat10_5.xyz) + u_xlat3.yyy;
    u_xlat16_6 = ceil(_ColorOffset);
    u_xlat16_11.xyz = vec3(u_xlat16_6) * u_xlat16_11.xyz + u_xlat10_5.xyz;
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb7 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_23 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat7.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat7.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_0.x + u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_23 * _MaskColorPlus + _ColorScale;
    SV_Target0.w = u_xlat16_23;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
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
float u_xlat0;
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
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
lowp vec4 u_xlat10_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_7;
bool u_xlatb7;
mediump vec3 u_xlat16_11;
vec2 u_xlat14;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat7.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD5.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, vs_TEXCOORD6.xyz);
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat7.xx * vec2(_ViewUVOffset) + u_xlat14.xy;
    u_xlat7.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_21 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_21 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_21;
    u_xlat7.z = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_21;
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat7.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat7.xy);
    u_xlat10_5 = texture(_MainTex, u_xlat16_11.xy);
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat7.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.yz = u_xlat7.xz + u_xlat16_4.xx;
    u_xlat16_11.xyz = (-u_xlat10_5.xyz) + u_xlat3.yyy;
    u_xlat16_6 = ceil(_ColorOffset);
    u_xlat16_11.xyz = vec3(u_xlat16_6) * u_xlat16_11.xyz + u_xlat10_5.xyz;
    u_xlat16_7.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_7.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_7.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb7 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_23 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_11.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat7.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat7.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_4.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_4.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_0.x + u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_23 * _MaskColorPlus + _ColorScale;
    SV_Target0.w = u_xlat16_23;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
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
float u_xlat6;
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
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(u_xlat3.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_1.xy = vec2(u_xlat18) * vec2(_ViewUVOffset) + u_xlat6.xy;
    u_xlat6.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_18 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_18 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_18;
    u_xlat16_18 = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_18;
    u_xlat3.y = u_xlat16_4.x + u_xlat16_18;
    u_xlat16_10.x = ceil(_ColorOffset);
    u_xlat16_5.xyz = (-u_xlat10_1.xyz) + u_xlat3.yyy;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_5.xyz + u_xlat10_1.xyz;
    u_xlat10_1 = texture(_MainTex, u_xlat6.xy);
    u_xlat16_5.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_5 = texture(_MainTex, u_xlat16_5.xy);
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.z = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_10.xyz);
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat6.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat6.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_20 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_20 + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb6 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_20 = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_20 = u_xlat16_20 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_0.x + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_20 * _MaskColorPlus + _ColorScale;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat16_20;
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
float u_xlat0;
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
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _ColorOffset;
uniform 	mediump float _ColorScale;
uniform 	mediump float _MaskColorPlus;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_10;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _DistortOffsetScale;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(u_xlat3.xyz, vs_TEXCOORD6.xyz);
    u_xlat16_1.xy = vec2(u_xlat18) * vec2(_ViewUVOffset) + u_xlat6.xy;
    u_xlat6.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat16_0.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_4.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_3.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_18 = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_18 = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_18;
    u_xlat16_18 = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_18;
    u_xlat3.y = u_xlat16_4.x + u_xlat16_18;
    u_xlat16_10.x = ceil(_ColorOffset);
    u_xlat16_5.xyz = (-u_xlat10_1.xyz) + u_xlat3.yyy;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_5.xyz + u_xlat10_1.xyz;
    u_xlat10_1 = texture(_MainTex, u_xlat6.xy);
    u_xlat16_5.xy = (-u_xlat16_0.xx) * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat6.xy;
    u_xlat10_5 = texture(_MainTex, u_xlat16_5.xy);
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_1.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.x = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_6.xy = u_xlat16_2.xy * u_xlat10_5.xy;
    u_xlat16_6.x = u_xlat16_6.y + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.z * u_xlat16_2.z + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat10_5.w * u_xlat16_2.w + u_xlat16_6.x;
    u_xlat3.z = u_xlat16_4.x + u_xlat16_6.x;
    u_xlat16_2.xyz = u_xlat3.xyz + (-u_xlat16_10.xyz);
    u_xlat16_2.xyz = vec3(vec3(_ColorOffset, _ColorOffset, _ColorOffset)) * u_xlat16_2.xyz + u_xlat16_10.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat6.xy;
    u_xlat16_4.xy = vec2(_DistortMask) * u_xlat16_0.xx + u_xlat6.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_4.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_20 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_20 + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat3.y>=0.689999998);
#else
    u_xlatb6 = u_xlat3.y>=0.689999998;
#endif
    u_xlat16_20 = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_4.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_20 = u_xlat16_20 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_0.x + u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_20 * _MaskColorPlus + _ColorScale;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat16_20;
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
  GpuProgramID 76629
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
  GpuProgramID 152916
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump vec2 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_2.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_2.x;
    u_xlat16_8.x = u_xlat16_8.x * _DistortOffsetScale;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_2.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat0.x = u_xlat16_0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.689999998);
#else
    u_xlatb0 = u_xlat0.x>=0.689999998;
#endif
    u_xlat16_2.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat0.xy;
    u_xlat16_6.xy = vec2(_DistortMask) * u_xlat16_8.xx + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_6.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_6.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_6.x;
    u_xlat16_6.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_6.x) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0 = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
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
uniform 	mediump float _DistortUSpeed;
uniform 	mediump float _DistortVSpeed;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortOffsetScale;
uniform 	mediump vec2 _ColorOffestThreshold;
uniform 	mediump float _USpeed;
uniform 	mediump float _VSpeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ViewUVOffset;
uniform 	mediump float _MainTexChannleNum;
uniform 	mediump float _MaskUSpeed;
uniform 	mediump float _MaskVSpeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _DistortMask;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump vec2 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD6.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = u_xlat0.xx * vec2(_ViewUVOffset) + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * vec2(_USpeed, _VSpeed) + u_xlat16_1.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_DistortUSpeed, _DistortVSpeed) + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_2.x = min(abs(_DistortChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_2.x;
    u_xlat16_8.x = u_xlat16_8.x * _DistortOffsetScale;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(_ColorOffestThreshold.x, _ColorOffestThreshold.y) + u_xlat0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_2.xy);
    u_xlat16_2 = (-vec4(vec4(_MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum, _MainTexChannleNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_MainTexChannleNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat0.x = u_xlat16_0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.689999998);
#else
    u_xlatb0 = u_xlat0.x>=0.689999998;
#endif
    u_xlat16_2.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskUSpeed, _MaskVSpeed) + u_xlat0.xy;
    u_xlat16_6.xy = vec2(_DistortMask) * u_xlat16_8.xx + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_6.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_6.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_6.x;
    u_xlat16_6.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_6.x) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0 = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}