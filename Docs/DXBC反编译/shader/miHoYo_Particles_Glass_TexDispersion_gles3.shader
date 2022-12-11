//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Glass_TexDispersion" {
Properties {
_DayColor ("_DayColor", Color) = (1,1,1,1)
_TintColor ("TintColor", Color) = (1,1,1,1)
_TintColorScale ("TintColorScale", Float) = 2
_BackColor ("BackColor", Color) = (1,1,1,1)
[MHYToggle] _ReverseFresnel ("ReverseFresnel", Float) = 0
_FresnelPower ("FresnelPower", Float) = 1
_MainTex ("MainTex", 2D) = "white" { }
_OnlyOffsetRChannel ("OnlyOffsetRChannel", Range(0, 1)) = 0
_OffsetColorScale ("OffsetColorScale", Float) = 1
_OffsetColorThreshold ("OffsetColorThreshold", Range(0, 9)) = 2.097886
_UVSpeedScale ("UVSpeedScale", Range(0, 2)) = 0.389241
_AffactByMainTex ("AffactByMainTex", Range(0, 1)) = 1
_AlphaChannelNum ("AlphaChannelNum", Range(0, 4)) = 0
_AlphaScale ("AlphaScale", Float) = 1
_FadeOutThreshold ("FadeOutThreshold", Range(0, 1)) = 0
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
[MHYToggle] _ReverseFadeOut ("ReverseFadeOut", Float) = 0
[MHYToggle] _UseCustomData ("UseCustomData", Float) = 0
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
  GpuProgramID 47360
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ReverseFresnel==1.0);
#else
    u_xlatb0 = _ReverseFresnel==1.0;
#endif
    u_xlat6.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD6.xyz;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, u_xlat6.xyz);
    u_xlat16_1 = u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = (u_xlatb0) ? u_xlat16_7.x : u_xlat16_1;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelPower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.xz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_7.xy = vec2(_UVSpeedScale) * u_xlat6.xx + u_xlat0.xz;
    u_xlat0.xz = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_7.xy;
    u_xlat0.xz = texture(_MainTex, u_xlat0.xz).xy;
    u_xlat2.y = u_xlat0.x;
    u_xlat3.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_7.xy;
    u_xlat10_4 = texture(_MainTex, u_xlat16_7.xy);
    u_xlat0.xw = texture(_MainTex, u_xlat3.xy).xz;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.x = u_xlat10_4.x;
    u_xlat2.x = u_xlat0.x;
    u_xlat16_7.xyz = (-u_xlat0.xzw) + u_xlat2.xyz;
    u_xlat16_5.x = floor(_OnlyOffsetRChannel);
    u_xlat16_7.xyz = u_xlat16_5.xxx * u_xlat16_7.xyz + u_xlat0.xzw;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_OffsetColorScale);
    u_xlat16_5.x = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xzw = u_xlat10_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xzw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_0.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_2 = vs_COLOR0 * _TintColor;
    u_xlat16_5.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    u_xlat16_7.xyz = vec3(_TintColorScale) * u_xlat16_5.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xzw = (-u_xlat16_7.xyz) + _BackColor.xyz;
    u_xlat16_0.xzw = vec3(u_xlat16_1) * u_xlat16_0.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_0.xzw * _DayColor.xyz;
    u_xlat0.x = (-u_xlat6.x) + 1.0;
    u_xlatb12.xy = equal(vec4(_ReverseFadeOut, _UseCustomData, _ReverseFadeOut, _UseCustomData), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_1 = (u_xlatb12.x) ? u_xlat0.x : u_xlat6.x;
    u_xlat16_7.x = (u_xlatb12.y) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_7.x = u_xlat16_7.x * 3.20000005 + -2.0;
    u_xlat16_1 = (-u_xlat16_7.x) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat10_4.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.z * u_xlat16_0.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.w * u_xlat16_0.w + u_xlat16_3.x;
    u_xlat16_7.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_3.x = u_xlat16_7.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_2.w * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_1 * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x;
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
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
struct miHoYoParticlesGlass_TexDispersionArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesGlass_TexDispersion {
	miHoYoParticlesGlass_TexDispersionArray_Type miHoYoParticlesGlass_TexDispersionArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
bool u_xlatb3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec3 u_xlatb7;
float u_xlat13;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = floor(_OnlyOffsetRChannel);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat13 = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat16_6.xy = vec2(_UVSpeedScale) * vec2(u_xlat13) + u_xlat1.xy;
    u_xlat1.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_6.xy;
    u_xlat1.xy = texture(_MainTex, u_xlat1.xy).xy;
    u_xlat2.y = u_xlat1.x;
    u_xlat3.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_6.xy;
    u_xlat10_4 = texture(_MainTex, u_xlat16_6.xy);
    u_xlat1.xw = texture(_MainTex, u_xlat3.xy).xz;
    u_xlat2.z = u_xlat1.x;
    u_xlat1.x = u_xlat10_4.x;
    u_xlat2.x = u_xlat1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyw) + u_xlat2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz + u_xlat1.xyw;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_OffsetColorScale);
    u_xlat16_18 = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesGlass_TexDispersionArray[u_xlati1]._MeshParticleColorArray;
    u_xlat16_2 = u_xlat2 * _TintColor;
    u_xlat16_1.xyw = u_xlat10_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_1.xyw + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.xyw * u_xlat16_2.xyz;
    u_xlat16_0.xyz = vec3(_TintColorScale) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyw = (-u_xlat16_0.xyz) + _BackColor.xyz;
    u_xlat16_18 = u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_18) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_ReverseFresnel==1.0);
#else
    u_xlatb3 = _ReverseFresnel==1.0;
#endif
    u_xlat16_18 = (u_xlatb3) ? u_xlat16_5.x : u_xlat16_18;
    u_xlat16_18 = max(u_xlat16_18, 9.99999975e-05);
    u_xlat16_18 = log2(u_xlat16_18);
    u_xlat16_18 = u_xlat16_18 * _FresnelPower;
    u_xlat16_18 = exp2(u_xlat16_18);
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    u_xlat16_1.xyw = vec3(u_xlat16_18) * u_xlat16_1.xyw + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyw * _DayColor.xyz;
    u_xlat1.x = (-u_xlat13) + 1.0;
    u_xlatb7.xz = equal(vec4(_ReverseFadeOut, _ReverseFadeOut, _UseCustomData, _UseCustomData), vec4(1.0, 0.0, 1.0, 1.0)).xz;
    u_xlat16_0.x = (u_xlatb7.x) ? u_xlat1.x : u_xlat13;
    u_xlat16_6.x = (u_xlatb7.z) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_6.x = u_xlat16_6.x * 3.20000005 + -2.0;
    u_xlat16_0.x = (-u_xlat16_6.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_4.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_6.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_3.x = u_xlat16_6.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_2.w * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0.x * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb8;
mediump vec3 u_xlat16_9;
float u_xlat14;
vec2 u_xlat17;
float u_xlat22;
mediump float u_xlat16_23;
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
    u_xlat14 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * vs_TEXCOORD6.xyz;
    u_xlat14 = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = vec2(_UVSpeedScale) * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_2.xy);
    u_xlat16_0.xyw = u_xlat10_1.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_0.xyw + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_2.xy;
    u_xlat10_3.xy = texture(_MainTex, u_xlat3.xy).xy;
    u_xlat17.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_2.xy;
    u_xlat4.yz = texture(_MainTex, u_xlat17.xy).zx;
    u_xlat16_2.x = floor(_OnlyOffsetRChannel);
    u_xlat5.x = u_xlat10_1.x;
    u_xlat5.y = u_xlat10_3.y;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.x;
    u_xlat4.y = u_xlat10_3.x;
    u_xlat16_9.xyz = (-u_xlat5.xyz) + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_OffsetColorScale);
    u_xlat16_23 = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_3 = vs_COLOR0 * _TintColor;
    u_xlat16_6.xyz = u_xlat16_0.xyw * u_xlat16_3.xyz;
    u_xlat16_2.xyz = vec3(_TintColorScale) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_ReverseFresnel==1.0);
#else
    u_xlatb0.x = _ReverseFresnel==1.0;
#endif
    u_xlat16_6.x = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = (u_xlatb0.x) ? u_xlat16_6.x : u_xlat16_23;
    u_xlat16_23 = max(u_xlat16_23, 9.99999975e-05);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _FresnelPower;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_23 = min(u_xlat16_23, 1.0);
    u_xlat16_0.xyw = (-u_xlat16_2.xyz) + _BackColor.xyz;
    u_xlat16_0.xyw = vec3(u_xlat16_23) * u_xlat16_0.xyw + u_xlat16_2.xyz;
    u_xlat16_2 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_6.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3.w;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlatb8.xy = equal(vec4(_ReverseFadeOut, _UseCustomData, _ReverseFadeOut, _ReverseFadeOut), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat22 = (-u_xlat14) + 1.0;
    u_xlat16_2.x = (u_xlatb8.x) ? u_xlat22 : u_xlat14;
    u_xlat16_9.x = (u_xlatb8.y) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_9.x = u_xlat16_9.x * 3.20000005 + -2.0;
    SV_Target0.xyz = u_xlat16_0.xyw * _DayColor.xyz;
    u_xlat16_2.x = (-u_xlat16_9.x) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_0.x;
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
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
struct miHoYoParticlesGlass_TexDispersionArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesGlass_TexDispersion {
	miHoYoParticlesGlass_TexDispersionArray_Type miHoYoParticlesGlass_TexDispersionArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb10;
mediump vec3 u_xlat16_11;
float u_xlat17;
vec2 u_xlat20;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesGlass_TexDispersionArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat17 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * vs_TEXCOORD6.xyz;
    u_xlat17 = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = vec2(_UVSpeedScale) * vec2(u_xlat17) + u_xlat1.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat16_3.xy);
    u_xlat16_1.xyw = u_xlat10_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_1.xyw + vec3(1.0, 1.0, 1.0);
    u_xlat4.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_3.xy;
    u_xlat10_4.xy = texture(_MainTex, u_xlat4.xy).xy;
    u_xlat20.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_3.xy;
    u_xlat5.yz = texture(_MainTex, u_xlat20.xy).zx;
    u_xlat16_3.x = floor(_OnlyOffsetRChannel);
    u_xlat6.x = u_xlat10_2.x;
    u_xlat6.y = u_xlat10_4.y;
    u_xlat6.z = u_xlat5.y;
    u_xlat5.x = u_xlat6.x;
    u_xlat5.y = u_xlat10_4.x;
    u_xlat16_11.xyz = (-u_xlat6.xyz) + u_xlat5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_11.xyz + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_OffsetColorScale);
    u_xlat16_27 = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_0 = u_xlat0 * _TintColor;
    u_xlat16_7.xyz = u_xlat16_1.xyw * u_xlat16_0.xyz;
    u_xlat16_3.xyz = vec3(_TintColorScale) * u_xlat16_7.xyz + u_xlat16_3.xyz;
    u_xlat16_27 = u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_ReverseFresnel==1.0);
#else
    u_xlatb1 = _ReverseFresnel==1.0;
#endif
    u_xlat16_7.x = (-u_xlat16_27) + 1.0;
    u_xlat16_27 = (u_xlatb1) ? u_xlat16_7.x : u_xlat16_27;
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = log2(u_xlat16_27);
    u_xlat16_27 = u_xlat16_27 * _FresnelPower;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.xyw = (-u_xlat16_3.xyz) + _BackColor.xyz;
    u_xlat16_1.xyw = vec3(u_xlat16_27) * u_xlat16_1.xyw + u_xlat16_3.xyz;
    u_xlat16_3 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_7.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlatb10.xy = equal(vec4(_ReverseFadeOut, _UseCustomData, _ReverseFadeOut, _ReverseFadeOut), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat26 = (-u_xlat17) + 1.0;
    u_xlat16_3.x = (u_xlatb10.x) ? u_xlat26 : u_xlat17;
    u_xlat16_11.x = (u_xlatb10.y) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_11.x = u_xlat16_11.x * 3.20000005 + -2.0;
    SV_Target0.xyz = u_xlat16_1.xyw * _DayColor.xyz;
    u_xlat16_3.x = (-u_xlat16_11.x) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_2.x * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_1.x;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ReverseFresnel==1.0);
#else
    u_xlatb0 = _ReverseFresnel==1.0;
#endif
    u_xlat6.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD6.xyz;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, u_xlat6.xyz);
    u_xlat16_1 = u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = (u_xlatb0) ? u_xlat16_7.x : u_xlat16_1;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelPower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.xz = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_7.xy = vec2(_UVSpeedScale) * u_xlat6.xx + u_xlat0.xz;
    u_xlat0.xz = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_7.xy;
    u_xlat0.xz = texture(_MainTex, u_xlat0.xz).xy;
    u_xlat2.y = u_xlat0.x;
    u_xlat3.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_7.xy;
    u_xlat10_4 = texture(_MainTex, u_xlat16_7.xy);
    u_xlat0.xw = texture(_MainTex, u_xlat3.xy).xz;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.x = u_xlat10_4.x;
    u_xlat2.x = u_xlat0.x;
    u_xlat16_7.xyz = (-u_xlat0.xzw) + u_xlat2.xyz;
    u_xlat16_5.x = floor(_OnlyOffsetRChannel);
    u_xlat16_7.xyz = u_xlat16_5.xxx * u_xlat16_7.xyz + u_xlat0.xzw;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_OffsetColorScale);
    u_xlat16_5.x = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xzw = u_xlat10_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xzw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_0.xzw + vec3(1.0, 1.0, 1.0);
    u_xlat16_2 = vs_COLOR0 * _TintColor;
    u_xlat16_5.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    u_xlat16_7.xyz = vec3(_TintColorScale) * u_xlat16_5.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xzw = (-u_xlat16_7.xyz) + _BackColor.xyz;
    u_xlat16_0.xzw = vec3(u_xlat16_1) * u_xlat16_0.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_0.xzw * _DayColor.xyz;
    u_xlat0.x = (-u_xlat6.x) + 1.0;
    u_xlatb12.xy = equal(vec4(_ReverseFadeOut, _UseCustomData, _ReverseFadeOut, _UseCustomData), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_1 = (u_xlatb12.x) ? u_xlat0.x : u_xlat6.x;
    u_xlat16_7.x = (u_xlatb12.y) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_7.x = u_xlat16_7.x * 3.20000005 + -2.0;
    u_xlat16_1 = (-u_xlat16_7.x) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat10_4.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.z * u_xlat16_0.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.w * u_xlat16_0.w + u_xlat16_3.x;
    u_xlat16_7.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_3.x = u_xlat16_7.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_2.w * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_1 * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x;
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
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
struct miHoYoParticlesGlass_TexDispersionArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesGlass_TexDispersion {
	miHoYoParticlesGlass_TexDispersionArray_Type miHoYoParticlesGlass_TexDispersionArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec2 u_xlat16_3;
bool u_xlatb3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec3 u_xlatb7;
float u_xlat13;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = floor(_OnlyOffsetRChannel);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD6.xyz;
    u_xlat13 = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat16_6.xy = vec2(_UVSpeedScale) * vec2(u_xlat13) + u_xlat1.xy;
    u_xlat1.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_6.xy;
    u_xlat1.xy = texture(_MainTex, u_xlat1.xy).xy;
    u_xlat2.y = u_xlat1.x;
    u_xlat3.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_6.xy;
    u_xlat10_4 = texture(_MainTex, u_xlat16_6.xy);
    u_xlat1.xw = texture(_MainTex, u_xlat3.xy).xz;
    u_xlat2.z = u_xlat1.x;
    u_xlat1.x = u_xlat10_4.x;
    u_xlat2.x = u_xlat1.x;
    u_xlat16_6.xyz = (-u_xlat1.xyw) + u_xlat2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz + u_xlat1.xyw;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_OffsetColorScale);
    u_xlat16_18 = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesGlass_TexDispersionArray[u_xlati1]._MeshParticleColorArray;
    u_xlat16_2 = u_xlat2 * _TintColor;
    u_xlat16_1.xyw = u_xlat10_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_1.xyw + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.xyw * u_xlat16_2.xyz;
    u_xlat16_0.xyz = vec3(_TintColorScale) * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyw = (-u_xlat16_0.xyz) + _BackColor.xyz;
    u_xlat16_18 = u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_18) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_ReverseFresnel==1.0);
#else
    u_xlatb3 = _ReverseFresnel==1.0;
#endif
    u_xlat16_18 = (u_xlatb3) ? u_xlat16_5.x : u_xlat16_18;
    u_xlat16_18 = max(u_xlat16_18, 9.99999975e-05);
    u_xlat16_18 = log2(u_xlat16_18);
    u_xlat16_18 = u_xlat16_18 * _FresnelPower;
    u_xlat16_18 = exp2(u_xlat16_18);
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    u_xlat16_1.xyw = vec3(u_xlat16_18) * u_xlat16_1.xyw + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyw * _DayColor.xyz;
    u_xlat1.x = (-u_xlat13) + 1.0;
    u_xlatb7.xz = equal(vec4(_ReverseFadeOut, _ReverseFadeOut, _UseCustomData, _UseCustomData), vec4(1.0, 0.0, 1.0, 1.0)).xz;
    u_xlat16_0.x = (u_xlatb7.x) ? u_xlat1.x : u_xlat13;
    u_xlat16_6.x = (u_xlatb7.z) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_6.x = u_xlat16_6.x * 3.20000005 + -2.0;
    u_xlat16_0.x = (-u_xlat16_6.x) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_1.xy * u_xlat10_4.xy;
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_4.w * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_6.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_3.x = u_xlat16_6.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_2.w * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0.x * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec2 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb8;
mediump vec3 u_xlat16_9;
float u_xlat14;
vec2 u_xlat17;
float u_xlat22;
mediump float u_xlat16_23;
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
    u_xlat14 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * vs_TEXCOORD6.xyz;
    u_xlat14 = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = vec2(_UVSpeedScale) * vec2(u_xlat14) + u_xlat0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_2.xy);
    u_xlat16_0.xyw = u_xlat10_1.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_0.xyw + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_2.xy;
    u_xlat10_3.xy = texture(_MainTex, u_xlat3.xy).xy;
    u_xlat17.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_2.xy;
    u_xlat4.yz = texture(_MainTex, u_xlat17.xy).zx;
    u_xlat16_2.x = floor(_OnlyOffsetRChannel);
    u_xlat5.x = u_xlat10_1.x;
    u_xlat5.y = u_xlat10_3.y;
    u_xlat5.z = u_xlat4.y;
    u_xlat4.x = u_xlat5.x;
    u_xlat4.y = u_xlat10_3.x;
    u_xlat16_9.xyz = (-u_xlat5.xyz) + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_OffsetColorScale);
    u_xlat16_23 = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_3 = vs_COLOR0 * _TintColor;
    u_xlat16_6.xyz = u_xlat16_0.xyw * u_xlat16_3.xyz;
    u_xlat16_2.xyz = vec3(_TintColorScale) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_ReverseFresnel==1.0);
#else
    u_xlatb0.x = _ReverseFresnel==1.0;
#endif
    u_xlat16_6.x = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = (u_xlatb0.x) ? u_xlat16_6.x : u_xlat16_23;
    u_xlat16_23 = max(u_xlat16_23, 9.99999975e-05);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _FresnelPower;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_23 = min(u_xlat16_23, 1.0);
    u_xlat16_0.xyw = (-u_xlat16_2.xyz) + _BackColor.xyz;
    u_xlat16_0.xyw = vec3(u_xlat16_23) * u_xlat16_0.xyw + u_xlat16_2.xyz;
    u_xlat16_2 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_6.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3.w;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlatb8.xy = equal(vec4(_ReverseFadeOut, _UseCustomData, _ReverseFadeOut, _ReverseFadeOut), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat22 = (-u_xlat14) + 1.0;
    u_xlat16_2.x = (u_xlatb8.x) ? u_xlat22 : u_xlat14;
    u_xlat16_9.x = (u_xlatb8.y) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_9.x = u_xlat16_9.x * 3.20000005 + -2.0;
    SV_Target0.xyz = u_xlat16_0.xyw * _DayColor.xyz;
    u_xlat16_2.x = (-u_xlat16_9.x) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_0.x;
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
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _TintColorScale;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AffactByMainTex;
uniform 	mediump float _OffsetColorThreshold;
uniform 	mediump float _OnlyOffsetRChannel;
uniform 	mediump float _OffsetColorScale;
uniform 	mediump vec4 _BackColor;
uniform 	mediump float _ReverseFresnel;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
struct miHoYoParticlesGlass_TexDispersionArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesGlass_TexDispersion {
	miHoYoParticlesGlass_TexDispersionArray_Type miHoYoParticlesGlass_TexDispersionArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bvec2 u_xlatb0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb10;
mediump vec3 u_xlat16_11;
float u_xlat17;
vec2 u_xlat20;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesGlass_TexDispersionArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat17 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * vs_TEXCOORD6.xyz;
    u_xlat17 = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = vec2(_UVSpeedScale) * vec2(u_xlat17) + u_xlat1.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat16_3.xy);
    u_xlat16_1.xyw = u_xlat10_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyw = vec3(vec3(_AffactByMainTex, _AffactByMainTex, _AffactByMainTex)) * u_xlat16_1.xyw + vec3(1.0, 1.0, 1.0);
    u_xlat4.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(0.100000001, -0.100000001) + u_xlat16_3.xy;
    u_xlat10_4.xy = texture(_MainTex, u_xlat4.xy).xy;
    u_xlat20.xy = vec2(vec2(_OffsetColorThreshold, _OffsetColorThreshold)) * vec2(-0.100000001, 0.100000001) + u_xlat16_3.xy;
    u_xlat5.yz = texture(_MainTex, u_xlat20.xy).zx;
    u_xlat16_3.x = floor(_OnlyOffsetRChannel);
    u_xlat6.x = u_xlat10_2.x;
    u_xlat6.y = u_xlat10_4.y;
    u_xlat6.z = u_xlat5.y;
    u_xlat5.x = u_xlat6.x;
    u_xlat5.y = u_xlat10_4.x;
    u_xlat16_11.xyz = (-u_xlat6.xyz) + u_xlat5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_11.xyz + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_OffsetColorScale);
    u_xlat16_27 = _OffsetColorThreshold;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_0 = u_xlat0 * _TintColor;
    u_xlat16_7.xyz = u_xlat16_1.xyw * u_xlat16_0.xyz;
    u_xlat16_3.xyz = vec3(_TintColorScale) * u_xlat16_7.xyz + u_xlat16_3.xyz;
    u_xlat16_27 = u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_ReverseFresnel==1.0);
#else
    u_xlatb1 = _ReverseFresnel==1.0;
#endif
    u_xlat16_7.x = (-u_xlat16_27) + 1.0;
    u_xlat16_27 = (u_xlatb1) ? u_xlat16_7.x : u_xlat16_27;
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = log2(u_xlat16_27);
    u_xlat16_27 = u_xlat16_27 * _FresnelPower;
    u_xlat16_27 = exp2(u_xlat16_27);
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.xyw = (-u_xlat16_3.xyz) + _BackColor.xyz;
    u_xlat16_1.xyw = vec3(u_xlat16_27) * u_xlat16_1.xyw + u_xlat16_3.xyz;
    u_xlat16_3 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_7.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_7.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlatb10.xy = equal(vec4(_ReverseFadeOut, _UseCustomData, _ReverseFadeOut, _ReverseFadeOut), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat26 = (-u_xlat17) + 1.0;
    u_xlat16_3.x = (u_xlatb10.x) ? u_xlat26 : u_xlat17;
    u_xlat16_11.x = (u_xlatb10.y) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_11.x = u_xlat16_11.x * 3.20000005 + -2.0;
    SV_Target0.xyz = u_xlat16_1.xyw * _DayColor.xyz;
    u_xlat16_3.x = (-u_xlat16_11.x) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_2.x * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_1.x;
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
  GpuProgramID 105553
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
  GpuProgramID 171599
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
ivec2 u_xlati1;
mediump vec4 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
vec2 u_xlat6;
ivec2 u_xlati6;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD6.xyz;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = vec2(_UVSpeedScale) * u_xlat6.xx + u_xlat0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_2.xy);
    u_xlat16_2 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat16_2.x = vs_COLOR0.w * _TintColor.w;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat6.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_ReverseFadeOut==1.0);
#else
    u_xlatb9 = _ReverseFadeOut==1.0;
#endif
    u_xlat16_2.x = (u_xlatb9) ? u_xlat3 : u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_UseCustomData==1.0);
#else
    u_xlatb3 = _UseCustomData==1.0;
#endif
    u_xlat16_5 = (u_xlatb3) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_5 = u_xlat16_5 * 3.20000005 + -2.0;
    u_xlat16_2.x = (-u_xlat16_5) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.x * u_xlat16_2.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0 = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
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
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _UVSpeedScale;
uniform 	mediump float _AlphaChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _ReverseFadeOut;
uniform 	mediump float _UseCustomData;
uniform 	mediump float _FadeOutThreshold;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
ivec2 u_xlati1;
mediump vec4 u_xlat16_2;
float u_xlat3;
int u_xlati3;
bool u_xlatb3;
mediump float u_xlat16_5;
vec2 u_xlat6;
ivec2 u_xlati6;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD6.xyz;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = vec2(_UVSpeedScale) * u_xlat6.xx + u_xlat0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_2.xy);
    u_xlat16_2 = (-vec4(vec4(_AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum, _AlphaChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_AlphaChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat3 = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati3]._MeshParticleColorArray.w;
    u_xlat16_2.x = u_xlat3 * _TintColor.w;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat6.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_ReverseFadeOut==1.0);
#else
    u_xlatb9 = _ReverseFadeOut==1.0;
#endif
    u_xlat16_2.x = (u_xlatb9) ? u_xlat3 : u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_UseCustomData==1.0);
#else
    u_xlatb3 = _UseCustomData==1.0;
#endif
    u_xlat16_5 = (u_xlatb3) ? vs_TEXCOORD1.x : _FadeOutThreshold;
    u_xlat16_5 = u_xlat16_5 * 3.20000005 + -2.0;
    u_xlat16_2.x = (-u_xlat16_5) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_0.x * u_xlat16_2.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0 = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
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