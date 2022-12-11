//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/SpiritWolf" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_MainTex ("MainTex", 2D) = "white" { }
_PatternTexInUV2 ("PatternTexInUV2", 2D) = "white" { }
_FresnelColor ("FresnelColor", Color) = (0.4999999,0.375,1,0)
_PatternColor ("PatternColor", Color) = (0.4999999,0.375,1,0)
_EyeColor ("EyeColor", Color) = (0.3382353,0.4523327,1,0)
_FresnelScale ("FresnelScale", Float) = 3
_FresnelPower ("FresnelPower", Float) = 3
_Opacity ("Opacity", Float) = 1
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseTx_U_Speed ("NoiseTx_U_Speed", Float) = 1
_NoiseTx_V_Speed ("NoiseTx_V_Speed", Float) = 1
_NoiseMultiplier ("NoiseMultiplier", Float) = 1
_NoisOffset ("NoisOffset", Float) = 0
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_NoiseTex02_U_Speed ("NoiseTex02_U_Speed", Float) = 1
_NoiseTex02_V_Speed ("NoiseTex02_V_Speed", Float) = 1
_Noise02Multiplier ("Noise02Multiplier", Float) = 0
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 19976
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat0.xxx * _FresnelColor.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 + _NoisOffset;
    u_xlat16_1 = u_xlat16_1 * _NoiseMultiplier;
    u_xlat6.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_6.xy = texture(_PatternTexInUV2, u_xlat6.xy).xy;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_6.x;
    u_xlat6.xz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture(_MainTex, u_xlat6.xz);
    u_xlat16_3.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat4.xyz = (-_MainColor.xyz) * u_xlat10_2.xyz + _PatternColor.xyz;
    u_xlat1.xyw = vec3(u_xlat16_1) * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat10_6.yyy * _EyeColor.xyz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat10_2.xyz * u_xlat5.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2.w;
    u_xlat16_1 = u_xlat16_1 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_1) + u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_2.w * u_xlat16_6 + u_xlat16_1;
    u_xlat0.w = u_xlat16_1 * _Opacity;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat0.xxx * _FresnelColor.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 + _NoisOffset;
    u_xlat16_1 = u_xlat16_1 * _NoiseMultiplier;
    u_xlat6.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_6.xy = texture(_PatternTexInUV2, u_xlat6.xy).xy;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_6.x;
    u_xlat6.xz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture(_MainTex, u_xlat6.xz);
    u_xlat16_3.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat4.xyz = (-_MainColor.xyz) * u_xlat10_2.xyz + _PatternColor.xyz;
    u_xlat1.xyw = vec3(u_xlat16_1) * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat10_6.yyy * _EyeColor.xyz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat10_2.xyz * u_xlat5.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2.w;
    u_xlat16_1 = u_xlat16_1 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_1) + u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_2.w * u_xlat16_6 + u_xlat16_1;
    u_xlat0.w = u_xlat16_1 * _Opacity;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat0.xxx * _FresnelColor.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 + _NoisOffset;
    u_xlat16_1 = u_xlat16_1 * _NoiseMultiplier;
    u_xlat6.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_6.xy = texture(_PatternTexInUV2, u_xlat6.xy).xy;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_6.x;
    u_xlat6.xz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture(_MainTex, u_xlat6.xz);
    u_xlat16_3.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat4.xyz = (-_MainColor.xyz) * u_xlat10_2.xyz + _PatternColor.xyz;
    u_xlat1.xyw = vec3(u_xlat16_1) * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat10_6.yyy * _EyeColor.xyz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat10_2.xyz * u_xlat5.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2.w;
    u_xlat16_1 = u_xlat16_1 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_1) + u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_2.w * u_xlat16_6 + u_xlat16_1;
    u_xlat0.w = u_xlat16_1 * _Opacity;
    SV_Target0 = u_xlat0;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat0.xxx * _FresnelColor.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 + _NoisOffset;
    u_xlat16_1 = u_xlat16_1 * _NoiseMultiplier;
    u_xlat6.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_6.xy = texture(_PatternTexInUV2, u_xlat6.xy).xy;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_6.x;
    u_xlat6.xz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture(_MainTex, u_xlat6.xz);
    u_xlat16_3.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat4.xyz = (-_MainColor.xyz) * u_xlat10_2.xyz + _PatternColor.xyz;
    u_xlat1.xyw = vec3(u_xlat16_1) * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat10_6.yyy * _EyeColor.xyz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat10_2.xyz * u_xlat5.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2.w;
    u_xlat16_1 = u_xlat16_1 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat16_1) + u_xlat10_2.w;
    u_xlat16_1 = u_xlat10_2.w * u_xlat16_6 + u_xlat16_1;
    u_xlat0.w = u_xlat16_1 * _Opacity;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_1.xy = texture(_PatternTexInUV2, u_xlat1.xy).xy;
    u_xlat9.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat9.y;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat10_9 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_9 = u_xlat10_9 + _NoisOffset;
    u_xlat16_9 = u_xlat16_9 * _NoiseMultiplier;
    u_xlat16_1 = u_xlat16_9 * u_xlat10_1.x;
    u_xlat2.xyz = (-_MainColor.xyz) * u_xlat10_0.xyz + _PatternColor.xyz;
    u_xlat1.xzw = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat3.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelPower;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10_1.yyy * _EyeColor.xyz + u_xlat1.xzw;
    u_xlat6.xyz = u_xlat2.xxx * _FresnelColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat6.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat0.y;
    u_xlat10_0.x = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat10_0.w;
    u_xlat16_0 = u_xlat16_0 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat16_0) + u_xlat10_0.w;
    u_xlat16_0 = u_xlat10_0.w * u_xlat16_4 + u_xlat16_0;
    u_xlat1.w = u_xlat16_0 * _Opacity;
    SV_Target0 = u_xlat1;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_1.xy = texture(_PatternTexInUV2, u_xlat1.xy).xy;
    u_xlat9.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat9.y;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat10_9 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_9 = u_xlat10_9 + _NoisOffset;
    u_xlat16_9 = u_xlat16_9 * _NoiseMultiplier;
    u_xlat16_1 = u_xlat16_9 * u_xlat10_1.x;
    u_xlat2.xyz = (-_MainColor.xyz) * u_xlat10_0.xyz + _PatternColor.xyz;
    u_xlat1.xzw = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat3.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelPower;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10_1.yyy * _EyeColor.xyz + u_xlat1.xzw;
    u_xlat6.xyz = u_xlat2.xxx * _FresnelColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat6.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat0.y;
    u_xlat10_0.x = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat10_0.w;
    u_xlat16_0 = u_xlat16_0 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat16_0) + u_xlat10_0.w;
    u_xlat16_0 = u_xlat10_0.w * u_xlat16_4 + u_xlat16_0;
    u_xlat1.w = u_xlat16_0 * _Opacity;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_1.xy = texture(_PatternTexInUV2, u_xlat1.xy).xy;
    u_xlat9.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat9.y;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat10_9 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_9 = u_xlat10_9 + _NoisOffset;
    u_xlat16_9 = u_xlat16_9 * _NoiseMultiplier;
    u_xlat16_1 = u_xlat16_9 * u_xlat10_1.x;
    u_xlat2.xyz = (-_MainColor.xyz) * u_xlat10_0.xyz + _PatternColor.xyz;
    u_xlat1.xzw = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat3.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelPower;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10_1.yyy * _EyeColor.xyz + u_xlat1.xzw;
    u_xlat6.xyz = u_xlat2.xxx * _FresnelColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat6.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat0.y;
    u_xlat10_0.x = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat10_0.w;
    u_xlat16_0 = u_xlat16_0 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat16_0) + u_xlat10_0.w;
    u_xlat16_0 = u_xlat10_0.w * u_xlat16_4 + u_xlat16_0;
    u_xlat1.w = u_xlat16_0 * _Opacity;
    SV_Target0 = u_xlat1;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _PatternColor;
uniform 	vec4 _PatternTexInUV2_ST;
uniform 	float _NoiseTx_U_Speed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTx_V_Speed;
uniform 	mediump float _NoisOffset;
uniform 	mediump float _NoiseMultiplier;
uniform 	vec4 _EyeColor;
uniform 	vec4 _FresnelColor;
uniform 	float _FresnelPower;
uniform 	float _FresnelScale;
uniform 	float _NoiseTex02_U_Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _NoiseTex02_V_Speed;
uniform 	mediump float _Noise02Multiplier;
uniform 	float _Opacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PatternTexInUV2;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _PatternTexInUV2_ST.xy + _PatternTexInUV2_ST.zw;
    u_xlat10_1.xy = texture(_PatternTexInUV2, u_xlat1.xy).xy;
    u_xlat9.xy = vs_TEXCOORD1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTx_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _NoiseTx_V_Speed + u_xlat9.y;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat10_9 = texture(_NoiseTex, u_xlat2.xy).x;
    u_xlat16_9 = u_xlat10_9 + _NoisOffset;
    u_xlat16_9 = u_xlat16_9 * _NoiseMultiplier;
    u_xlat16_1 = u_xlat16_9 * u_xlat10_1.x;
    u_xlat2.xyz = (-_MainColor.xyz) * u_xlat10_0.xyz + _PatternColor.xyz;
    u_xlat1.xzw = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat3.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = max(u_xlat2.x, 9.99999975e-05);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelPower;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10_1.yyy * _EyeColor.xyz + u_xlat1.xzw;
    u_xlat6.xyz = u_xlat2.xxx * _FresnelColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat6.xyz + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex02_V_Speed + u_xlat0.y;
    u_xlat10_0.x = texture(_NoiseTex02, u_xlat2.xy).x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat10_0.w;
    u_xlat16_0 = u_xlat16_0 * _Noise02Multiplier;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat16_0) + u_xlat10_0.w;
    u_xlat16_0 = u_xlat10_0.w * u_xlat16_4 + u_xlat16_0;
    u_xlat1.w = u_xlat16_0 * _Opacity;
    SV_Target0 = u_xlat1;
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
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 109845
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