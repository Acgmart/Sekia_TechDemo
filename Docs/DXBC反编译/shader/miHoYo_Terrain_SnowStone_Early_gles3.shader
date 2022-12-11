//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Terrain/SnowStone_Early" {
Properties {
[Header(Main Setting)] _ElementViewEleID ("Element ID", Float) = 0
_MainColor ("Main Color", Color) = (1,1,1,1)
[Header(Stone)] _StoneDiffuse ("Stone Diffuse", 2D) = "white" { }
_StoneNormal ("Stone Normal", 2D) = "bump" { }
_StoneMask ("Stone Mask", 2D) = "black" { }
_StoneNormalScale ("Stone Normal Scale", Range(0, 5)) = 1
[Header(Snow Shape)] _SnowIntensity ("Snow Intensity (Mulit Vertex Color R)", Range(0, 1)) = 1
_SnowSoft ("Snow Soft (Mulit Vertex Color G)", Range(0, 1)) = 1
_SnowOffset ("Snow Offset (Add Vertex Color B)", Range(-5, 5)) = 1
_SnowDir ("Snow Direction", Vector) = (0.81,0.81,0.81,1)
[Space] _SeaAltitude ("Ref Sea Altitude", Float) = 0
_SnowAltitudeScale ("Snow Altitude Scale", Range(0, 1)) = 1
_SnowAltitudePower ("Snow Altitude Exponent", Range(0, 10)) = 1
[Header(Snow Color)] _SnowColor ("Snow Color", Color) = (1,1,1,1)
_SnowSmoothness ("Snow Smoothness", Range(0.2, 0.5)) = 0.5
_SnowNormalBlend ("Snow Normal Blend", Range(0, 1)) = 1
[Header(Depth Blend)] [Toggle(ENABLE_DEPTH_BLEND_ON)] _EnableDepthBlend ("Enable Depth Blend", Float) = 0
_DepthBiasScaled ("Depth bias scaled", Range(0, 16)) = 0.6
}
SubShader {
 Tags { "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 63743
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _MainColor;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _SnowAltitudePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat1.x = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_0.x = u_xlat1.x + _SnowOffset;
    u_xlat16_5.x = u_xlat1.x * _SnowIntensity;
    u_xlat1.x = u_xlat16_5.x * vs_COLOR0.x;
    u_xlat6 = u_xlat16_0.x + vs_COLOR0.z;
    u_xlat16_0.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SnowDir.xyz;
    u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_15 = inversesqrt(u_xlat16_15);
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat2.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat6;
    u_xlat6 = vs_COLOR0.y * _SnowSoft;
    u_xlat16_5.x = float(1.0) / u_xlat6;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_0.x * _SnowNormalBlend;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat16_10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_4.xyz = u_xlat1.xyz * vec3(u_xlat16_10) + (-u_xlat16_3.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = u_xlat16_5.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_1.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_2.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    u_xlat10_1.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = max(u_xlat10_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 0.999000013);
    u_xlat16_5.x = (-u_xlat16_1.x) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_0.x * u_xlat16_5.x + u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_0.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb1) ? u_xlat16_0.x : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _MainColor;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
vec3 u_xlat13;
mediump vec3 u_xlat16_13;
float u_xlat14;
float u_xlat23;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(_StoneNormalScale);
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat16_28 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    u_xlat27 = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat16_3 = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _SnowAltitudePower;
    u_xlat16_4.x = exp2(u_xlat16_3);
    u_xlat27 = u_xlat27 * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat27, 1.0);
    u_xlat16_4.x = u_xlat2.x * _SnowIntensity;
    u_xlat5 = u_xlat16_4.x * vs_COLOR0.x;
    u_xlat14 = vs_COLOR0.y * _SnowSoft;
    u_xlat16_4.x = u_xlat2.x + _SnowOffset;
    u_xlat23 = u_xlat16_4.x + vs_COLOR0.z;
    u_xlat16_4.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _SnowDir.xyz;
    u_xlat16_4.x = dot(u_xlat16_4.xyz, u_xlat16_1.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat23;
    u_xlat16_13.x = float(1.0) / u_xlat14;
    u_xlat16_4.x = u_xlat16_13.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_13.x = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * _MainColor.xyz;
    u_xlat16_6.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_13.x = u_xlat16_4.x * _SnowNormalBlend;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat16_28) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_13.xxx * u_xlat16_7.xyz + u_xlat16_1.xyz;
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_13.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(vs_TEXCOORD4.w<100.0);
#else
    u_xlatb32 = vs_TEXCOORD4.w<100.0;
#endif
    if(u_xlatb32){
        u_xlat6.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
        u_xlat32 = texture(_CameraDepthBlendTexture, u_xlat6.xy).x;
        u_xlat32 = _ZBufferParams.z * u_xlat32 + _ZBufferParams.w;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlat32 = u_xlat32 + (-vs_TEXCOORD4.w);
        u_xlat32 = abs(u_xlat32) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
        u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
        u_xlat32 = sqrt(u_xlat32);
        u_xlat10_8.xyz = texture(_CameraDepthBlendNormTexture, u_xlat6.xy).xyz;
        u_xlat16_7.xyz = u_xlat10_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_6.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat6.xy).xyz;
        u_xlat16_8.xyz = u_xlat16_5.xyz + (-u_xlat10_6.xyz);
        u_xlat6.xyz = vec3(u_xlat32) * u_xlat16_8.xyz + u_xlat10_6.xyz;
        u_xlat16_8.xyz = u_xlat16_1.xyz * vec3(u_xlat16_28) + (-u_xlat16_7.xyz);
        u_xlat8.xyz = vec3(u_xlat32) * u_xlat16_8.xyz + u_xlat16_7.xyz;
        u_xlat32 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat32 = inversesqrt(u_xlat32);
        u_xlat13.xyz = vec3(u_xlat32) * u_xlat8.xyz;
        u_xlat16_6.xyz = u_xlat6.xyz;
        u_xlat16_13.xyz = u_xlat13.xyz;
    } else {
        u_xlat16_6.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat10_5.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_5.x = max(u_xlat10_5.x, 0.00100000005);
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999000013);
    u_xlat16_1.x = (-u_xlat16_5.x) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_5.x;
    SV_Target0.xyz = u_xlat16_13.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb5) ? u_xlat16_1.x : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_6.xyz;
    SV_Target1.w = 0.0;
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
uniform 	vec4 _StoneDiffuse_ST;
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
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat17;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat5.x;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat5.y;
    vs_TEXCOORD3.w = u_xlat5.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _MainColor;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _SnowAltitudePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat1.x = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_0.x = u_xlat1.x + _SnowOffset;
    u_xlat16_5.x = u_xlat1.x * _SnowIntensity;
    u_xlat1.x = u_xlat16_5.x * vs_COLOR0.x;
    u_xlat6 = u_xlat16_0.x + vs_COLOR0.z;
    u_xlat16_0.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SnowDir.xyz;
    u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_15 = inversesqrt(u_xlat16_15);
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat2.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_3.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat6;
    u_xlat6 = vs_COLOR0.y * _SnowSoft;
    u_xlat16_5.x = float(1.0) / u_xlat6;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_5.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_0.x * _SnowNormalBlend;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat16_10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_4.xyz = u_xlat1.xyz * vec3(u_xlat16_10) + (-u_xlat16_3.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = u_xlat16_5.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_1.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_2.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    u_xlat10_1.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = max(u_xlat10_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 0.999000013);
    u_xlat16_5.x = (-u_xlat16_1.x) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_0.x * u_xlat16_5.x + u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_0.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb1) ? u_xlat16_0.x : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _StoneDiffuse_ST;
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
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat17;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat5.x;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat5.y;
    vs_TEXCOORD3.w = u_xlat5.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _MainColor;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
vec3 u_xlat13;
mediump vec3 u_xlat16_13;
float u_xlat14;
float u_xlat23;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(_StoneNormalScale);
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat16_28 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    u_xlat27 = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat16_3 = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _SnowAltitudePower;
    u_xlat16_4.x = exp2(u_xlat16_3);
    u_xlat27 = u_xlat27 * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat27, 1.0);
    u_xlat16_4.x = u_xlat2.x * _SnowIntensity;
    u_xlat5 = u_xlat16_4.x * vs_COLOR0.x;
    u_xlat14 = vs_COLOR0.y * _SnowSoft;
    u_xlat16_4.x = u_xlat2.x + _SnowOffset;
    u_xlat23 = u_xlat16_4.x + vs_COLOR0.z;
    u_xlat16_4.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _SnowDir.xyz;
    u_xlat16_4.x = dot(u_xlat16_4.xyz, u_xlat16_1.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat23;
    u_xlat16_13.x = float(1.0) / u_xlat14;
    u_xlat16_4.x = u_xlat16_13.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_13.x = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_5.xyz * _MainColor.xyz;
    u_xlat16_6.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_13.x = u_xlat16_4.x * _SnowNormalBlend;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat16_28) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_13.xxx * u_xlat16_7.xyz + u_xlat16_1.xyz;
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_13.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(vs_TEXCOORD4.w<100.0);
#else
    u_xlatb32 = vs_TEXCOORD4.w<100.0;
#endif
    if(u_xlatb32){
        u_xlat6.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
        u_xlat32 = texture(_CameraDepthBlendTexture, u_xlat6.xy).x;
        u_xlat32 = _ZBufferParams.z * u_xlat32 + _ZBufferParams.w;
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlat32 = u_xlat32 + (-vs_TEXCOORD4.w);
        u_xlat32 = abs(u_xlat32) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
        u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
        u_xlat32 = sqrt(u_xlat32);
        u_xlat10_8.xyz = texture(_CameraDepthBlendNormTexture, u_xlat6.xy).xyz;
        u_xlat16_7.xyz = u_xlat10_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_6.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat6.xy).xyz;
        u_xlat16_8.xyz = u_xlat16_5.xyz + (-u_xlat10_6.xyz);
        u_xlat6.xyz = vec3(u_xlat32) * u_xlat16_8.xyz + u_xlat10_6.xyz;
        u_xlat16_8.xyz = u_xlat16_1.xyz * vec3(u_xlat16_28) + (-u_xlat16_7.xyz);
        u_xlat8.xyz = vec3(u_xlat32) * u_xlat16_8.xyz + u_xlat16_7.xyz;
        u_xlat32 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat32 = inversesqrt(u_xlat32);
        u_xlat13.xyz = vec3(u_xlat32) * u_xlat8.xyz;
        u_xlat16_6.xyz = u_xlat6.xyz;
        u_xlat16_13.xyz = u_xlat13.xyz;
    } else {
        u_xlat16_6.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat10_5.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_5.x = max(u_xlat10_5.x, 0.00100000005);
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999000013);
    u_xlat16_1.x = (-u_xlat16_5.x) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_5.x;
    SV_Target0.xyz = u_xlat16_13.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb5) ? u_xlat16_1.x : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_6.xyz;
    SV_Target1.w = 0.0;
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
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _StoneDiffuse_ST;
uniform 	vec4 _StoneNormal_TexelSize;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec3 u_xlatb10;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
mediump float u_xlat16_16;
vec2 u_xlat19;
vec2 u_xlat20;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_33;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb27){
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
    u_xlatb27 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb27){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb27){
        u_xlat27 = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat27 = max(u_xlat27, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat27);
#else
        u_xlatb1.x = 256.0<u_xlat27;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat27)).xy;
        u_xlat2 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb27){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _StoneNormal_TexelSize.z, vs_TEXCOORD0.y * _StoneNormal_TexelSize.w);
        u_xlat19.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat27 = dot(u_xlat19.xy, u_xlat19.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat27 = max(u_xlat27, u_xlat1.x);
        u_xlat27 = log2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.5;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = u_xlat27 + 1.0;
        u_xlat1.x = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat27 = u_xlat1.x / u_xlat27;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat27);
#else
        u_xlatb1.x = 256.0<u_xlat27;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat27)).xy;
        u_xlat2 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb27){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_StoneDiffuse_ST.z), vs_TEXCOORD0.y + (-_StoneDiffuse_ST.w));
        u_xlat2.xy = vec2(_StoneDiffuse_ST.x * _StoneNormal_TexelSize.z, _StoneDiffuse_ST.y * _StoneNormal_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb27 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _StoneNormal_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb27)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb27 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat27 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat27 = max(u_xlat27, u_xlat3.x);
            u_xlat27 = log2(u_xlat27);
            u_xlat27 = u_xlat27 * 0.5;
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlat27 = u_xlat27 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat27);
            u_xlat27 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat11 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat29 = sqrt(u_xlat27);
            u_xlat3.x = sqrt(u_xlat11);
            u_xlat27 = inversesqrt(u_xlat27);
            u_xlat27 = u_xlat27 * abs(u_xlat2.z);
            u_xlat11 = inversesqrt(u_xlat11);
            u_xlat2.x = u_xlat11 * abs(u_xlat2.x);
            u_xlat27 = u_xlat27 * u_xlat2.x;
            u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
            u_xlat27 = sqrt(u_xlat27);
            u_xlat2.x = u_xlat29 * u_xlat3.x;
            u_xlat11 = u_xlat27 * u_xlat2.x;
            u_xlat20.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat20.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat20.xy = fract(u_xlat20.xy);
            u_xlat20.xy = u_xlat20.xy + vec2(0.5, 0.5);
            u_xlat20.xy = floor(u_xlat20.xy);
            u_xlat3.x = (-u_xlat20.x) + u_xlat3.x;
            u_xlat20.x = u_xlat3.x * u_xlat20.y + u_xlat20.x;
            u_xlat29 = (-u_xlat2.x) * u_xlat27 + 1.0;
            u_xlat3.xyz = (-u_xlat20.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat29) * u_xlat3.xyz + u_xlat20.xxx;
            u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat20.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat27 = u_xlat2.x * u_xlat27 + -4.0;
            u_xlat27 = exp2(u_xlat27);
            u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
            u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.zyy + u_xlat20.xxx;
            u_xlat2.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb27 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb27 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb27){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb27 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb27 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb27){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat29 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat29);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat29 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat29) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat29);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat27);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat29 = sqrt(u_xlat27);
                    u_xlat12 = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat3.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat29 * u_xlat12;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat29 = fract((-u_xlat19.x));
                    u_xlat29 = u_xlat29 + 0.5;
                    u_xlat29 = floor(u_xlat29);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat29 = (-u_xlat19.x) + u_xlat29;
                    u_xlat19.x = u_xlat29 * u_xlat19.y + u_xlat19.x;
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
                    u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
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
    u_xlatb27 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb27){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb27 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb27){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(_StoneNormalScale);
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat16_33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_6.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat1.xyz * u_xlat16_6.xxx;
    u_xlat27 = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat16_7.x = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SnowAltitudePower;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat27 = u_xlat27 * u_xlat16_7.x;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat16_7.x = u_xlat27 * _SnowIntensity;
    u_xlat1.x = u_xlat16_7.x * vs_COLOR0.x;
    u_xlat10 = vs_COLOR0.y * _SnowSoft;
    u_xlat16_7.x = u_xlat27 + _SnowOffset;
    u_xlat27 = u_xlat16_7.x + vs_COLOR0.z;
    u_xlat16_7.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SnowDir.xyz;
    u_xlat16_7.x = dot(u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_7.x = u_xlat27 + u_xlat16_7.x;
    u_xlat16_16 = float(1.0) / u_xlat10;
    u_xlat16_7.x = u_xlat16_16 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_16;
    u_xlat16_7.x = u_xlat1.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_2.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_16 = u_xlat16_7.x * _SnowNormalBlend;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(u_xlat16_33) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_16) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat10_0.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = max(u_xlat10_0.x, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat16_33 = (-u_xlat16_0) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_7.x * u_xlat16_33 + u_xlat16_0;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_6.x : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _StoneDiffuse_ST;
uniform 	vec4 _StoneNormal_TexelSize;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
bvec2 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec3 u_xlat15;
bool u_xlatb15;
vec3 u_xlat17;
mediump vec3 u_xlat16_17;
vec3 u_xlat20;
bvec3 u_xlatb20;
vec2 u_xlat27;
vec2 u_xlat32;
float u_xlat36;
mediump float u_xlat16_37;
float u_xlat38;
float u_xlat39;
bool u_xlatb39;
float u_xlat44;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(_StoneNormalScale);
    u_xlat2.x = vs_TEXCOORD1.z;
    u_xlat2.y = vs_TEXCOORD2.z;
    u_xlat2.z = vs_TEXCOORD3.z;
    u_xlat16_37 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
    u_xlat3.y = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat3.z = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat3.xyz;
    u_xlat36 = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat36 = max(u_xlat36, 0.0);
    u_xlat16_4 = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _SnowAltitudePower;
    u_xlat16_5.x = exp2(u_xlat16_4);
    u_xlat36 = u_xlat36 * u_xlat16_5.x;
    u_xlat38 = min(u_xlat36, 1.0);
    u_xlat16_5.x = u_xlat38 * _SnowIntensity;
    u_xlat3.x = u_xlat16_5.x * vs_COLOR0.x;
    u_xlat15.x = vs_COLOR0.y * _SnowSoft;
    u_xlat16_5.x = u_xlat38 + _SnowOffset;
    u_xlat27.x = u_xlat16_5.x + vs_COLOR0.z;
    u_xlat16_5.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _SnowDir.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_5.x = u_xlat27.x + u_xlat16_5.x;
    u_xlat16_17.x = float(1.0) / u_xlat15.x;
    u_xlat16_5.x = u_xlat16_17.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_17.x;
    u_xlat16_5.x = u_xlat3.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * _MainColor.xyz;
    u_xlat16_6.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_17.x = u_xlat16_5.x * _SnowNormalBlend;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(u_xlat16_37) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_17.xxx * u_xlat16_7.xyz + u_xlat16_1.xyz;
    u_xlat16_37 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_17.xyz = vec3(u_xlat16_37) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD4.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD4.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat6.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat6.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD4.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_8.xyz = texture(_CameraDepthBlendNormTexture, u_xlat6.xy).xyz;
        u_xlat16_7.xyz = u_xlat10_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_6.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat6.xy).xyz;
        u_xlat16_8.xyz = u_xlat16_3.xyz + (-u_xlat10_6.xyz);
        u_xlat6.xyz = vec3(u_xlat39) * u_xlat16_8.xyz + u_xlat10_6.xyz;
        u_xlat16_8.xyz = u_xlat16_1.xyz * vec3(u_xlat16_37) + (-u_xlat16_7.xyz);
        u_xlat8.xyz = vec3(u_xlat39) * u_xlat16_8.xyz + u_xlat16_7.xyz;
        u_xlat39 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat39 = inversesqrt(u_xlat39);
        u_xlat17.xyz = vec3(u_xlat39) * u_xlat8.xyz;
        u_xlat16_6.xyz = u_xlat6.xyz;
        u_xlat16_17.xyz = u_xlat17.xyz;
    } else {
        u_xlat16_6.xyz = u_xlat16_3.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb3.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb3.x){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb3.x){
        u_xlat3.x = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat3.x = max(u_xlat3.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(256.0<u_xlat3.x);
#else
        u_xlatb15 = 256.0<u_xlat3.x;
#endif
        u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
        u_xlat0 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat0 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (bool(u_xlatb15)) ? u_xlat0 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb3.x){
        u_xlat3.xy = vec2(vs_TEXCOORD0.x * _StoneNormal_TexelSize.z, vs_TEXCOORD0.y * _StoneNormal_TexelSize.w);
        u_xlat27.xy = dFdx(u_xlat3.xy);
        u_xlat3.xy = dFdy(u_xlat3.xy);
        u_xlat27.x = dot(u_xlat27.xy, u_xlat27.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat3.x = max(u_xlat3.x, u_xlat27.x);
        u_xlat3.x = log2(u_xlat3.x);
        u_xlat3.x = u_xlat3.x * 0.5;
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.x = u_xlat3.x + 1.0;
        u_xlat15.x = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat3.x = u_xlat15.x / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(256.0<u_xlat3.x);
#else
        u_xlatb15 = 256.0<u_xlat3.x;
#endif
        u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
        u_xlat0 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat0 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (bool(u_xlatb15)) ? u_xlat0 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb3.x){
        u_xlat0.zw = vec2(vs_TEXCOORD0.x + (-_StoneDiffuse_ST.z), vs_TEXCOORD0.y + (-_StoneDiffuse_ST.w));
        u_xlat3.xy = vec2(_StoneDiffuse_ST.x * _StoneNormal_TexelSize.z, _StoneDiffuse_ST.y * _StoneNormal_TexelSize.w);
        u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
        u_xlatb3.x = u_xlatb3.y || u_xlatb3.x;
        u_xlat0.xy = _StoneNormal_TexelSize.zw;
        u_xlat0 = (u_xlatb3.x) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb3.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb3.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb3.x){
            u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
            u_xlat3.zw = dFdx(u_xlat3.xy);
            u_xlat3.xy = dFdy(u_xlat3.xy);
            u_xlat8.x = dot(u_xlat3.zw, u_xlat3.zw);
            u_xlat20.x = dot(u_xlat3.xy, u_xlat3.xy);
            u_xlat8.x = max(u_xlat20.x, u_xlat8.x);
            u_xlat8.x = log2(u_xlat8.x);
            u_xlat8.x = u_xlat8.x * 0.5;
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlat8.x = u_xlat8.x + 1.0;
            u_xlat20.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat3 = u_xlat3 * u_xlat20.xxxx;
            u_xlat3 = u_xlat3 / u_xlat8.xxxx;
            u_xlat15.z = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
            u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
            u_xlat8.xy = sqrt(u_xlat15.zx);
            u_xlat15.z = inversesqrt(u_xlat15.z);
            u_xlat15.x = inversesqrt(u_xlat15.x);
            u_xlat3.xz = u_xlat15.xz * abs(u_xlat3.xz);
            u_xlat3.x = u_xlat3.x * u_xlat3.z;
            u_xlat3.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
            u_xlat3.x = sqrt(u_xlat3.x);
            u_xlat15.x = u_xlat8.y * u_xlat8.x;
            u_xlat27.x = u_xlat3.x * u_xlat15.x;
            u_xlat8.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
            u_xlat39 = fract((-u_xlat8.x));
            u_xlat39 = u_xlat39 + 0.5;
            u_xlat39 = floor(u_xlat39);
            u_xlat8.xy = fract(u_xlat8.xy);
            u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
            u_xlat8.xy = floor(u_xlat8.xy);
            u_xlat39 = u_xlat39 + (-u_xlat8.x);
            u_xlat39 = u_xlat39 * u_xlat8.y + u_xlat8.x;
            u_xlat8.x = (-u_xlat15.x) * u_xlat3.x + 1.0;
            u_xlat20.xyz = (-vec3(u_xlat39)) + vec3(0.5, 0.0, 1.0);
            u_xlat9.xyz = u_xlat8.xxx * u_xlat20.xyz + vec3(u_xlat39);
            u_xlatb8.xy = lessThan(u_xlat27.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat10.xyz = vec3(u_xlat39) * vec3(0.0, 1.0, 0.0);
            u_xlat3.x = u_xlat15.x * u_xlat3.x + -4.0;
            u_xlat3.x = exp2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
            u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
            u_xlat3.xyz = u_xlat3.xxx * u_xlat20.zyy + vec3(u_xlat39);
            u_xlat3.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat3.xyz;
            u_xlat3.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat3.xyz;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb39 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb39 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb39){
                u_xlat3.x = float(0.0);
                u_xlat3.y = float(0.0);
                u_xlat3.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb39 = !!(u_xlat0.x>=0.0);
#else
                u_xlatb39 = u_xlat0.x>=0.0;
#endif
                if(u_xlatb39){
                    u_xlat8.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat8.zw = dFdx(u_xlat8.xy);
                    u_xlat8.xy = dFdy(u_xlat8.xy);
                    u_xlat39 = dot(u_xlat8.zw, u_xlat8.zw);
                    u_xlat9.x = dot(u_xlat8.xy, u_xlat8.xy);
                    u_xlat39 = max(u_xlat39, u_xlat9.x);
                    u_xlat39 = log2(u_xlat39);
                    u_xlat39 = u_xlat39 * 0.5;
                    u_xlat39 = max(u_xlat39, 0.0);
                    u_xlat39 = u_xlat39 + 1.0;
                    u_xlat9.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat8 = u_xlat8 * u_xlat9.xxxx;
                    u_xlat8 = u_xlat8 / vec4(u_xlat39);
                    u_xlat39 = dot(abs(u_xlat8.zw), abs(u_xlat8.zw));
                    u_xlat20.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                    u_xlat44 = sqrt(u_xlat39);
                    u_xlat9.x = sqrt(u_xlat20.x);
                    u_xlat39 = inversesqrt(u_xlat39);
                    u_xlat39 = u_xlat39 * abs(u_xlat8.z);
                    u_xlat20.x = inversesqrt(u_xlat20.x);
                    u_xlat8.x = u_xlat20.x * abs(u_xlat8.x);
                    u_xlat39 = u_xlat39 * u_xlat8.x;
                    u_xlat39 = (-u_xlat39) * u_xlat39 + 1.0;
                    u_xlat39 = sqrt(u_xlat39);
                    u_xlat8.x = u_xlat44 * u_xlat9.x;
                    u_xlat20.x = u_xlat39 * u_xlat8.x;
                    u_xlat32.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat9.x = fract((-u_xlat32.x));
                    u_xlat9.x = u_xlat9.x + 0.5;
                    u_xlat9.x = floor(u_xlat9.x);
                    u_xlat32.xy = fract(u_xlat32.xy);
                    u_xlat32.xy = u_xlat32.xy + vec2(0.5, 0.5);
                    u_xlat32.xy = floor(u_xlat32.xy);
                    u_xlat9.x = (-u_xlat32.x) + u_xlat9.x;
                    u_xlat32.x = u_xlat9.x * u_xlat32.y + u_xlat32.x;
                    u_xlat44 = (-u_xlat8.x) * u_xlat39 + 1.0;
                    u_xlat9.xyz = (-u_xlat32.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat10.xyz = vec3(u_xlat44) * u_xlat9.xyz + u_xlat32.xxx;
                    u_xlatb20.xz = lessThan(u_xlat20.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat11.xyz = u_xlat32.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat39 = u_xlat8.x * u_xlat39 + -4.0;
                    u_xlat39 = exp2(u_xlat39);
                    u_xlat39 = u_xlat39 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
                    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
                    u_xlat9.xyz = vec3(u_xlat39) * u_xlat9.zyy + u_xlat32.xxx;
                    u_xlat8.xzw = (u_xlatb20.z) ? u_xlat11.xyz : u_xlat9.xyz;
                    u_xlat3.xyz = (u_xlatb20.x) ? u_xlat10.xyz : u_xlat8.xzw;
                } else {
                    u_xlat3.x = float(0.0);
                    u_xlat3.y = float(0.0);
                    u_xlat3.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb3.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb3.x = u_xlatb3.y || u_xlatb3.x;
    if(u_xlatb3.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb3.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb3.x = u_xlatb3.y || u_xlatb3.x;
    if(u_xlatb3.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_3.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_3.x = max(u_xlat10_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999000013);
    u_xlat16_7.x = (-u_xlat16_3.x) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_5.x * u_xlat16_7.x + u_xlat16_3.x;
    SV_Target0.xyz = u_xlat16_17.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb3.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_5.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb3.x) ? u_xlat16_5.x : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_6.xyz;
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
uniform 	vec4 _StoneDiffuse_ST;
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
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat17;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat5.x;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat5.y;
    vs_TEXCOORD3.w = u_xlat5.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _StoneDiffuse_ST;
uniform 	vec4 _StoneNormal_TexelSize;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec3 u_xlatb10;
float u_xlat11;
bvec3 u_xlatb11;
float u_xlat12;
mediump float u_xlat16_16;
vec2 u_xlat19;
vec2 u_xlat20;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_33;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb27){
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
    u_xlatb27 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb27){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb27){
        u_xlat27 = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat27 = max(u_xlat27, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat27);
#else
        u_xlatb1.x = 256.0<u_xlat27;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat27)).xy;
        u_xlat2 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb27){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _StoneNormal_TexelSize.z, vs_TEXCOORD0.y * _StoneNormal_TexelSize.w);
        u_xlat19.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat27 = dot(u_xlat19.xy, u_xlat19.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat27 = max(u_xlat27, u_xlat1.x);
        u_xlat27 = log2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.5;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = u_xlat27 + 1.0;
        u_xlat1.x = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat27 = u_xlat1.x / u_xlat27;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat27);
#else
        u_xlatb1.x = 256.0<u_xlat27;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat27)).xy;
        u_xlat2 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb27 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb27){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_StoneDiffuse_ST.z), vs_TEXCOORD0.y + (-_StoneDiffuse_ST.w));
        u_xlat2.xy = vec2(_StoneDiffuse_ST.x * _StoneNormal_TexelSize.z, _StoneDiffuse_ST.y * _StoneNormal_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb27 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _StoneNormal_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb27)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb27 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat27 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat27 = max(u_xlat27, u_xlat3.x);
            u_xlat27 = log2(u_xlat27);
            u_xlat27 = u_xlat27 * 0.5;
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlat27 = u_xlat27 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat27);
            u_xlat27 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat11 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat29 = sqrt(u_xlat27);
            u_xlat3.x = sqrt(u_xlat11);
            u_xlat27 = inversesqrt(u_xlat27);
            u_xlat27 = u_xlat27 * abs(u_xlat2.z);
            u_xlat11 = inversesqrt(u_xlat11);
            u_xlat2.x = u_xlat11 * abs(u_xlat2.x);
            u_xlat27 = u_xlat27 * u_xlat2.x;
            u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
            u_xlat27 = sqrt(u_xlat27);
            u_xlat2.x = u_xlat29 * u_xlat3.x;
            u_xlat11 = u_xlat27 * u_xlat2.x;
            u_xlat20.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat20.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat20.xy = fract(u_xlat20.xy);
            u_xlat20.xy = u_xlat20.xy + vec2(0.5, 0.5);
            u_xlat20.xy = floor(u_xlat20.xy);
            u_xlat3.x = (-u_xlat20.x) + u_xlat3.x;
            u_xlat20.x = u_xlat3.x * u_xlat20.y + u_xlat20.x;
            u_xlat29 = (-u_xlat2.x) * u_xlat27 + 1.0;
            u_xlat3.xyz = (-u_xlat20.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat29) * u_xlat3.xyz + u_xlat20.xxx;
            u_xlatb11.xz = lessThan(vec4(u_xlat11), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat20.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat27 = u_xlat2.x * u_xlat27 + -4.0;
            u_xlat27 = exp2(u_xlat27);
            u_xlat27 = u_xlat27 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
            u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.zyy + u_xlat20.xxx;
            u_xlat2.xzw = (u_xlatb11.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb11.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb27 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb27 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb27){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb27 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb27 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb27){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat27 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat29 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat27 = max(u_xlat27, u_xlat29);
                    u_xlat27 = log2(u_xlat27);
                    u_xlat27 = u_xlat27 * 0.5;
                    u_xlat27 = max(u_xlat27, 0.0);
                    u_xlat27 = u_xlat27 + 1.0;
                    u_xlat29 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat29) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat29);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat27);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat27);
                    u_xlat27 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat10 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat29 = sqrt(u_xlat27);
                    u_xlat12 = sqrt(u_xlat10);
                    u_xlat27 = inversesqrt(u_xlat27);
                    u_xlat27 = u_xlat27 * abs(u_xlat3.x);
                    u_xlat10 = inversesqrt(u_xlat10);
                    u_xlat1.x = u_xlat10 * abs(u_xlat1.x);
                    u_xlat27 = u_xlat27 * u_xlat1.x;
                    u_xlat27 = (-u_xlat27) * u_xlat27 + 1.0;
                    u_xlat27 = sqrt(u_xlat27);
                    u_xlat1.x = u_xlat29 * u_xlat12;
                    u_xlat10 = u_xlat27 * u_xlat1.x;
                    u_xlat19.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat29 = fract((-u_xlat19.x));
                    u_xlat29 = u_xlat29 + 0.5;
                    u_xlat29 = floor(u_xlat29);
                    u_xlat19.xy = fract(u_xlat19.xy);
                    u_xlat19.xy = u_xlat19.xy + vec2(0.5, 0.5);
                    u_xlat19.xy = floor(u_xlat19.xy);
                    u_xlat29 = (-u_xlat19.x) + u_xlat29;
                    u_xlat19.x = u_xlat29 * u_xlat19.y + u_xlat19.x;
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
                    u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
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
    u_xlatb27 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb27){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb27 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb27){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(_StoneNormalScale);
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat16_33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_6.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat1.xyz * u_xlat16_6.xxx;
    u_xlat27 = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat16_7.x = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SnowAltitudePower;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat27 = u_xlat27 * u_xlat16_7.x;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat16_7.x = u_xlat27 * _SnowIntensity;
    u_xlat1.x = u_xlat16_7.x * vs_COLOR0.x;
    u_xlat10 = vs_COLOR0.y * _SnowSoft;
    u_xlat16_7.x = u_xlat27 + _SnowOffset;
    u_xlat27 = u_xlat16_7.x + vs_COLOR0.z;
    u_xlat16_7.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SnowDir.xyz;
    u_xlat16_7.x = dot(u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_7.x = u_xlat27 + u_xlat16_7.x;
    u_xlat16_16 = float(1.0) / u_xlat10;
    u_xlat16_7.x = u_xlat16_16 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_16;
    u_xlat16_7.x = u_xlat1.x * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_2.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_16 = u_xlat16_7.x * _SnowNormalBlend;
    u_xlat16_8.xyz = u_xlat0.xyz * vec3(u_xlat16_33) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_16) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat10_0.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = max(u_xlat10_0.x, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat16_33 = (-u_xlat16_0) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_7.x * u_xlat16_33 + u_xlat16_0;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_6.x : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _StoneDiffuse_ST;
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
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat17;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    vs_TEXCOORD1.y = u_xlat16_4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat5.x;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat5.y;
    vs_TEXCOORD3.w = u_xlat5.z;
    vs_TEXCOORD2.y = u_xlat16_4.y;
    vs_TEXCOORD3.y = u_xlat16_4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _DepthBiasScaled;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _StoneDiffuse_ST;
uniform 	vec4 _StoneNormal_TexelSize;
uniform 	float _StoneNormalScale;
uniform 	mediump vec3 _SnowDir;
uniform 	mediump float _SnowIntensity;
uniform 	mediump vec3 _SnowColor;
uniform 	mediump float _SeaAltitude;
uniform 	mediump float _SnowAltitudeScale;
uniform 	mediump float _SnowAltitudePower;
uniform 	mediump float _SnowSmoothness;
uniform 	mediump float _SnowSoft;
uniform 	mediump float _SnowOffset;
uniform 	mediump float _SnowNormalBlend;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
uniform lowp sampler2D _StoneMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
bvec2 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
vec3 u_xlat15;
bool u_xlatb15;
vec3 u_xlat17;
mediump vec3 u_xlat16_17;
vec3 u_xlat20;
bvec3 u_xlatb20;
vec2 u_xlat27;
vec2 u_xlat32;
float u_xlat36;
mediump float u_xlat16_37;
float u_xlat38;
float u_xlat39;
bool u_xlatb39;
float u_xlat44;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(_StoneNormalScale);
    u_xlat2.x = vs_TEXCOORD1.z;
    u_xlat2.y = vs_TEXCOORD2.z;
    u_xlat2.z = vs_TEXCOORD3.z;
    u_xlat16_37 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
    u_xlat3.y = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat3.z = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat3.xyz;
    u_xlat36 = vs_TEXCOORD2.w + (-_SeaAltitude);
    u_xlat36 = max(u_xlat36, 0.0);
    u_xlat16_4 = _SnowAltitudeScale + 9.99999975e-05;
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _SnowAltitudePower;
    u_xlat16_5.x = exp2(u_xlat16_4);
    u_xlat36 = u_xlat36 * u_xlat16_5.x;
    u_xlat38 = min(u_xlat36, 1.0);
    u_xlat16_5.x = u_xlat38 * _SnowIntensity;
    u_xlat3.x = u_xlat16_5.x * vs_COLOR0.x;
    u_xlat15.x = vs_COLOR0.y * _SnowSoft;
    u_xlat16_5.x = u_xlat38 + _SnowOffset;
    u_xlat27.x = u_xlat16_5.x + vs_COLOR0.z;
    u_xlat16_5.x = dot(_SnowDir.xyz, _SnowDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _SnowDir.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_5.x = u_xlat27.x + u_xlat16_5.x;
    u_xlat16_17.x = float(1.0) / u_xlat15.x;
    u_xlat16_5.x = u_xlat16_17.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_17.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_17.x;
    u_xlat16_5.x = u_xlat3.x * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * _MainColor.xyz;
    u_xlat16_6.xyz = _SnowColor.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_17.x = u_xlat16_5.x * _SnowNormalBlend;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(u_xlat16_37) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_17.xxx * u_xlat16_7.xyz + u_xlat16_1.xyz;
    u_xlat16_37 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_17.xyz = vec3(u_xlat16_37) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(vs_TEXCOORD4.w<100.0);
#else
    u_xlatb39 = vs_TEXCOORD4.w<100.0;
#endif
    if(u_xlatb39){
        u_xlat6.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
        u_xlat39 = texture(_CameraDepthBlendTexture, u_xlat6.xy).x;
        u_xlat39 = _ZBufferParams.z * u_xlat39 + _ZBufferParams.w;
        u_xlat39 = float(1.0) / u_xlat39;
        u_xlat39 = u_xlat39 + (-vs_TEXCOORD4.w);
        u_xlat39 = abs(u_xlat39) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
        u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
        u_xlat39 = sqrt(u_xlat39);
        u_xlat10_8.xyz = texture(_CameraDepthBlendNormTexture, u_xlat6.xy).xyz;
        u_xlat16_7.xyz = u_xlat10_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_6.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat6.xy).xyz;
        u_xlat16_8.xyz = u_xlat16_3.xyz + (-u_xlat10_6.xyz);
        u_xlat6.xyz = vec3(u_xlat39) * u_xlat16_8.xyz + u_xlat10_6.xyz;
        u_xlat16_8.xyz = u_xlat16_1.xyz * vec3(u_xlat16_37) + (-u_xlat16_7.xyz);
        u_xlat8.xyz = vec3(u_xlat39) * u_xlat16_8.xyz + u_xlat16_7.xyz;
        u_xlat39 = dot(u_xlat8.xyz, u_xlat8.xyz);
        u_xlat39 = inversesqrt(u_xlat39);
        u_xlat17.xyz = vec3(u_xlat39) * u_xlat8.xyz;
        u_xlat16_6.xyz = u_xlat6.xyz;
        u_xlat16_17.xyz = u_xlat17.xyz;
    } else {
        u_xlat16_6.xyz = u_xlat16_3.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb3.x){
        u_xlatb3.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb3.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb3.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb3.x){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb3.x){
        u_xlat3.x = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat3.x = max(u_xlat3.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(256.0<u_xlat3.x);
#else
        u_xlatb15 = 256.0<u_xlat3.x;
#endif
        u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
        u_xlat0 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat0 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (bool(u_xlatb15)) ? u_xlat0 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb3.x){
        u_xlat3.xy = vec2(vs_TEXCOORD0.x * _StoneNormal_TexelSize.z, vs_TEXCOORD0.y * _StoneNormal_TexelSize.w);
        u_xlat27.xy = dFdx(u_xlat3.xy);
        u_xlat3.xy = dFdy(u_xlat3.xy);
        u_xlat27.x = dot(u_xlat27.xy, u_xlat27.xy);
        u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
        u_xlat3.x = max(u_xlat3.x, u_xlat27.x);
        u_xlat3.x = log2(u_xlat3.x);
        u_xlat3.x = u_xlat3.x * 0.5;
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.x = u_xlat3.x + 1.0;
        u_xlat15.x = max(_StoneNormal_TexelSize.w, _StoneNormal_TexelSize.z);
        u_xlat3.x = u_xlat15.x / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(256.0<u_xlat3.x);
#else
        u_xlatb15 = 256.0<u_xlat3.x;
#endif
        u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
        u_xlat0 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat0 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat0;
        u_xlat0 = (bool(u_xlatb15)) ? u_xlat0 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb3.x = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb3.x){
        u_xlat0.zw = vec2(vs_TEXCOORD0.x + (-_StoneDiffuse_ST.z), vs_TEXCOORD0.y + (-_StoneDiffuse_ST.w));
        u_xlat3.xy = vec2(_StoneDiffuse_ST.x * _StoneNormal_TexelSize.z, _StoneDiffuse_ST.y * _StoneNormal_TexelSize.w);
        u_xlatb3.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat3.xyxx).xy;
        u_xlatb3.x = u_xlatb3.y || u_xlatb3.x;
        u_xlat0.xy = _StoneNormal_TexelSize.zw;
        u_xlat0 = (u_xlatb3.x) ? u_xlat0 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb3.x = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb3.x = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb3.x){
            u_xlat3.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
            u_xlat3.zw = dFdx(u_xlat3.xy);
            u_xlat3.xy = dFdy(u_xlat3.xy);
            u_xlat8.x = dot(u_xlat3.zw, u_xlat3.zw);
            u_xlat20.x = dot(u_xlat3.xy, u_xlat3.xy);
            u_xlat8.x = max(u_xlat20.x, u_xlat8.x);
            u_xlat8.x = log2(u_xlat8.x);
            u_xlat8.x = u_xlat8.x * 0.5;
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlat8.x = u_xlat8.x + 1.0;
            u_xlat20.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat3 = u_xlat3 * u_xlat20.xxxx;
            u_xlat3 = u_xlat3 / u_xlat8.xxxx;
            u_xlat15.z = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
            u_xlat15.x = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
            u_xlat8.xy = sqrt(u_xlat15.zx);
            u_xlat15.z = inversesqrt(u_xlat15.z);
            u_xlat15.x = inversesqrt(u_xlat15.x);
            u_xlat3.xz = u_xlat15.xz * abs(u_xlat3.xz);
            u_xlat3.x = u_xlat3.x * u_xlat3.z;
            u_xlat3.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
            u_xlat3.x = sqrt(u_xlat3.x);
            u_xlat15.x = u_xlat8.y * u_xlat8.x;
            u_xlat27.x = u_xlat3.x * u_xlat15.x;
            u_xlat8.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
            u_xlat39 = fract((-u_xlat8.x));
            u_xlat39 = u_xlat39 + 0.5;
            u_xlat39 = floor(u_xlat39);
            u_xlat8.xy = fract(u_xlat8.xy);
            u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
            u_xlat8.xy = floor(u_xlat8.xy);
            u_xlat39 = u_xlat39 + (-u_xlat8.x);
            u_xlat39 = u_xlat39 * u_xlat8.y + u_xlat8.x;
            u_xlat8.x = (-u_xlat15.x) * u_xlat3.x + 1.0;
            u_xlat20.xyz = (-vec3(u_xlat39)) + vec3(0.5, 0.0, 1.0);
            u_xlat9.xyz = u_xlat8.xxx * u_xlat20.xyz + vec3(u_xlat39);
            u_xlatb8.xy = lessThan(u_xlat27.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
            u_xlat10.xyz = vec3(u_xlat39) * vec3(0.0, 1.0, 0.0);
            u_xlat3.x = u_xlat15.x * u_xlat3.x + -4.0;
            u_xlat3.x = exp2(u_xlat3.x);
            u_xlat3.x = u_xlat3.x + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
            u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
            u_xlat3.xyz = u_xlat3.xxx * u_xlat20.zyy + vec3(u_xlat39);
            u_xlat3.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat3.xyz;
            u_xlat3.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat3.xyz;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb39 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb39 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb39){
                u_xlat3.x = float(0.0);
                u_xlat3.y = float(0.0);
                u_xlat3.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb39 = !!(u_xlat0.x>=0.0);
#else
                u_xlatb39 = u_xlat0.x>=0.0;
#endif
                if(u_xlatb39){
                    u_xlat8.xy = vec2(u_xlat0.x * u_xlat0.z, u_xlat0.y * u_xlat0.w);
                    u_xlat8.zw = dFdx(u_xlat8.xy);
                    u_xlat8.xy = dFdy(u_xlat8.xy);
                    u_xlat39 = dot(u_xlat8.zw, u_xlat8.zw);
                    u_xlat9.x = dot(u_xlat8.xy, u_xlat8.xy);
                    u_xlat39 = max(u_xlat39, u_xlat9.x);
                    u_xlat39 = log2(u_xlat39);
                    u_xlat39 = u_xlat39 * 0.5;
                    u_xlat39 = max(u_xlat39, 0.0);
                    u_xlat39 = u_xlat39 + 1.0;
                    u_xlat9.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat8 = u_xlat8 * u_xlat9.xxxx;
                    u_xlat8 = u_xlat8 / vec4(u_xlat39);
                    u_xlat39 = dot(abs(u_xlat8.zw), abs(u_xlat8.zw));
                    u_xlat20.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                    u_xlat44 = sqrt(u_xlat39);
                    u_xlat9.x = sqrt(u_xlat20.x);
                    u_xlat39 = inversesqrt(u_xlat39);
                    u_xlat39 = u_xlat39 * abs(u_xlat8.z);
                    u_xlat20.x = inversesqrt(u_xlat20.x);
                    u_xlat8.x = u_xlat20.x * abs(u_xlat8.x);
                    u_xlat39 = u_xlat39 * u_xlat8.x;
                    u_xlat39 = (-u_xlat39) * u_xlat39 + 1.0;
                    u_xlat39 = sqrt(u_xlat39);
                    u_xlat8.x = u_xlat44 * u_xlat9.x;
                    u_xlat20.x = u_xlat39 * u_xlat8.x;
                    u_xlat32.xy = vec2(u_xlat0.z * float(3.0), u_xlat0.w * float(3.0));
                    u_xlat9.x = fract((-u_xlat32.x));
                    u_xlat9.x = u_xlat9.x + 0.5;
                    u_xlat9.x = floor(u_xlat9.x);
                    u_xlat32.xy = fract(u_xlat32.xy);
                    u_xlat32.xy = u_xlat32.xy + vec2(0.5, 0.5);
                    u_xlat32.xy = floor(u_xlat32.xy);
                    u_xlat9.x = (-u_xlat32.x) + u_xlat9.x;
                    u_xlat32.x = u_xlat9.x * u_xlat32.y + u_xlat32.x;
                    u_xlat44 = (-u_xlat8.x) * u_xlat39 + 1.0;
                    u_xlat9.xyz = (-u_xlat32.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat10.xyz = vec3(u_xlat44) * u_xlat9.xyz + u_xlat32.xxx;
                    u_xlatb20.xz = lessThan(u_xlat20.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat11.xyz = u_xlat32.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat39 = u_xlat8.x * u_xlat39 + -4.0;
                    u_xlat39 = exp2(u_xlat39);
                    u_xlat39 = u_xlat39 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
                    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
                    u_xlat9.xyz = vec3(u_xlat39) * u_xlat9.zyy + u_xlat32.xxx;
                    u_xlat8.xzw = (u_xlatb20.z) ? u_xlat11.xyz : u_xlat9.xyz;
                    u_xlat3.xyz = (u_xlatb20.x) ? u_xlat10.xyz : u_xlat8.xzw;
                } else {
                    u_xlat3.x = float(0.0);
                    u_xlat3.y = float(0.0);
                    u_xlat3.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat3.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb3.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb3.x = u_xlatb3.y || u_xlatb3.x;
    if(u_xlatb3.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb3.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb3.x = u_xlatb3.y || u_xlatb3.x;
    if(u_xlatb3.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat10_3.x = texture(_StoneMask, vs_TEXCOORD0.xy).x;
    u_xlat16_3.x = max(u_xlat10_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999000013);
    u_xlat16_7.x = (-u_xlat16_3.x) + _SnowSmoothness;
    SV_Target2.w = u_xlat16_5.x * u_xlat16_7.x + u_xlat16_3.x;
    SV_Target0.xyz = u_xlat16_17.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb3.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_5.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb3.x) ? u_xlat16_5.x : 0.0399999991;
    SV_Target0.w = 0.0;
    SV_Target1.xyz = u_xlat16_6.xyz;
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
Keywords { "ENABLE_DEPTH_BLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_DEPTH_BLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "ENABLE_DEPTH_BLEND_ON" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 85971
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
uniform 	vec4 _NearDetailDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat16_3.x = u_xlat12 * 0.330000013;
    u_xlat2.xy = u_xlat16_3.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD2.zw = u_xlat2.xy * _NearDetailDiffuse_ST.xy + _NearDetailDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_3.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _GrassNormalScale;
uniform 	float _MaskBlendIntensity;
uniform 	float _MaskBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform 	mediump float _NearDetailNormalScale;
uniform 	mediump float _NearDetailDiffuseDistance;
uniform 	mediump float _NearDetailDiffuseFade;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassMask;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _NearDetailNormal;
uniform lowp sampler2D _NearDetailMask;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_11;
bool u_xlatb11;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat22;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_27;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
float u_xlat42;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb11 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat10_1.xy = texture(_GrassNormal, vs_TEXCOORD0.xy).xy;
        u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_GrassNormalScale);
        u_xlat16_24 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
        u_xlat16_24 = (-u_xlat16_24) + 1.00010002;
        u_xlat16_3.z = sqrt(u_xlat16_24);
        u_xlat10_1.x = texture(_GrassMask, vs_TEXCOORD0.xy).x;
        u_xlat16_4.xyz = u_xlat10_0.xzw;
        u_xlat16_24 = u_xlat10_1.x;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_3.z = 1.0;
        u_xlat16_24 = _DefaultSmoothness_Grass;
    //ENDIF
    }
    if(u_xlatb11){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _NearDetailDiffuseDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _NearDetailDiffuseFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat11.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_1.xy = texture(_StoneNormal, vs_TEXCOORD0.zw).xy;
        u_xlat16_5.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat10_1.xy = texture(_NearDetailNormal, vs_TEXCOORD2.zw).xy;
        u_xlat16_27.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_27.xy = u_xlat16_27.xy * vec2(_NearDetailNormalScale);
        u_xlat16_35 = (-u_xlat0.x) + 1.0;
        u_xlat16_35 = u_xlat16_35 * vs_COLOR0.x;
        u_xlat16_27.xy = vec2(u_xlat16_35) * u_xlat16_27.xy;
        u_xlat10_1.x = texture(_NearDetailMask, vs_TEXCOORD2.zw).x;
        u_xlat16_35 = dot(u_xlat11.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
        u_xlatb12 = !!(u_xlat16_35<0.108300656);
#else
        u_xlatb12 = u_xlat16_35<0.108300656;
#endif
        u_xlat16_6.xyz = (bool(u_xlatb12)) ? u_xlat11.xyz : vec3(0.214967459, 0.214967459, 0.214967459);
        u_xlat16_6.xyz = (-u_xlat11.xyz) + u_xlat16_6.xyz;
        u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.00100000005, 0.00100000005, 0.00100000005) + u_xlat11.xyz;
        u_xlat16_7.xyz = u_xlat11.xyz + (-u_xlat16_6.xyz);
        u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
        u_xlat16_35 = (-u_xlat10_1.x) + _DefaultSmoothness_Stone;
        u_xlat16_35 = u_xlat0.x * u_xlat16_35 + u_xlat10_1.x;
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_StoneNormalScale) + u_xlat16_27.xy;
        u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz;
    } else {
        u_xlat16_6.x = float(0.0);
        u_xlat16_6.y = float(0.0);
        u_xlat16_6.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_35 = _DefaultSmoothness_Stone;
    //ENDIF
    }
    u_xlat16_7.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_8.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xy = u_xlat16_5.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod)) + u_xlat16_2.xy;
    u_xlat16_5.z = 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_7.yyy * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_2.x = vs_COLOR0.w * _MaskBlendIntensity;
    u_xlat16_13 = u_xlat16_35 + -1.0;
    u_xlat16_13 = _MaskBlendMethod * u_xlat16_13 + 1.0;
    u_xlat16_13 = u_xlat16_24 * u_xlat16_13 + (-u_xlat16_35);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_13 + u_xlat16_35;
    u_xlat16_0 = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat9.x = vs_TEXCOORD3.w;
    u_xlat9.y = vs_TEXCOORD4.w;
    u_xlat9.z = vs_TEXCOORD5.w;
    u_xlat11.xyz = (-u_xlat9.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat42 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat42 = inversesqrt(u_xlat42);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat9.xyz = (-u_xlat9.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat10);
    u_xlat16_35 = (-u_xlat16_0) + 1.0;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_36 = u_xlat1.y * u_xlat1.y;
    u_xlat16_36 = u_xlat1.x * u_xlat1.x + (-u_xlat16_36);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_36) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_36 = dot(u_xlat9.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat11.xyz * vec3(u_xlat42) + u_xlat9.xyz;
    u_xlat16_37 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_4.xyz = vec3(u_xlat16_37) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11.x = dot(u_xlat9.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_33 = u_xlat16_22 * u_xlat16_22;
    u_xlat1.x = u_xlat0.x * u_xlat16_33 + (-u_xlat0.x);
    u_xlat0.x = u_xlat1.x * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_33 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat16_22 = (-u_xlat16_22) * u_xlat16_22 + 1.0;
    u_xlat16_22 = u_xlat16_22 + u_xlat16_22;
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat16_35 = u_xlat11.x * u_xlat11.x;
    u_xlat16_35 = u_xlat11.x * u_xlat16_35;
    u_xlat16_35 = u_xlat11.x * u_xlat16_35;
    u_xlat16_35 = u_xlat11.x * u_xlat16_35;
    u_xlat16_11 = u_xlat16_35 * 0.959999979;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_22 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_36) + u_xlat16_3.xyz;
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
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
uniform 	vec4 _NearDetailDiffuse_ST;
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
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7 = sqrt(u_xlat7);
    u_xlat2.x = u_xlat7 + u_xlat2.x;
    u_xlat16_4.x = u_xlat2.x * 0.330000013;
    u_xlat2.xy = u_xlat16_4.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD2.zw = u_xlat2.xy * _NearDetailDiffuse_ST.xy + _NearDetailDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_4.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_4.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _GrassNormalScale;
uniform 	float _MaskBlendIntensity;
uniform 	float _MaskBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform 	mediump float _NearDetailNormalScale;
uniform 	mediump float _NearDetailDiffuseDistance;
uniform 	mediump float _NearDetailDiffuseFade;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _GrassNormal;
uniform lowp sampler2D _GrassMask;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _NearDetailNormal;
uniform lowp sampler2D _NearDetailMask;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
float u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_11;
bool u_xlatb11;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat22;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_27;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
float u_xlat42;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb11 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat10_1.xy = texture(_GrassNormal, vs_TEXCOORD0.xy).xy;
        u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_GrassNormalScale);
        u_xlat16_24 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
        u_xlat16_24 = (-u_xlat16_24) + 1.00010002;
        u_xlat16_3.z = sqrt(u_xlat16_24);
        u_xlat10_1.x = texture(_GrassMask, vs_TEXCOORD0.xy).x;
        u_xlat16_4.xyz = u_xlat10_0.xzw;
        u_xlat16_24 = u_xlat10_1.x;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_3.z = 1.0;
        u_xlat16_24 = _DefaultSmoothness_Grass;
    //ENDIF
    }
    if(u_xlatb11){
        u_xlat0.x = vs_TEXCOORD3.w;
        u_xlat0.y = vs_TEXCOORD4.w;
        u_xlat0.z = vs_TEXCOORD5.w;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x / _NearDetailDiffuseDistance;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = u_xlat0.x + 9.99999975e-05;
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * _NearDetailDiffuseFade;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = min(u_xlat0.x, 1.0);
        u_xlat11.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_1.xy = texture(_StoneNormal, vs_TEXCOORD0.zw).xy;
        u_xlat16_5.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat10_1.xy = texture(_NearDetailNormal, vs_TEXCOORD2.zw).xy;
        u_xlat16_27.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
        u_xlat16_27.xy = u_xlat16_27.xy * vec2(_NearDetailNormalScale);
        u_xlat16_35 = (-u_xlat0.x) + 1.0;
        u_xlat16_35 = u_xlat16_35 * vs_COLOR0.x;
        u_xlat16_27.xy = vec2(u_xlat16_35) * u_xlat16_27.xy;
        u_xlat10_1.x = texture(_NearDetailMask, vs_TEXCOORD2.zw).x;
        u_xlat16_35 = dot(u_xlat11.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
        u_xlatb12 = !!(u_xlat16_35<0.108300656);
#else
        u_xlatb12 = u_xlat16_35<0.108300656;
#endif
        u_xlat16_6.xyz = (bool(u_xlatb12)) ? u_xlat11.xyz : vec3(0.214967459, 0.214967459, 0.214967459);
        u_xlat16_6.xyz = (-u_xlat11.xyz) + u_xlat16_6.xyz;
        u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.00100000005, 0.00100000005, 0.00100000005) + u_xlat11.xyz;
        u_xlat16_7.xyz = u_xlat11.xyz + (-u_xlat16_6.xyz);
        u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
        u_xlat16_35 = (-u_xlat10_1.x) + _DefaultSmoothness_Stone;
        u_xlat16_35 = u_xlat0.x * u_xlat16_35 + u_xlat10_1.x;
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(_StoneNormalScale) + u_xlat16_27.xy;
        u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz;
    } else {
        u_xlat16_6.x = float(0.0);
        u_xlat16_6.y = float(0.0);
        u_xlat16_6.z = float(0.0);
        u_xlat16_5.x = float(0.0);
        u_xlat16_5.y = float(0.0);
        u_xlat16_35 = _DefaultSmoothness_Stone;
    //ENDIF
    }
    u_xlat16_7.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_8.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xy = u_xlat16_5.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod)) + u_xlat16_2.xy;
    u_xlat16_5.z = 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_7.yyy * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_2.x = vs_COLOR0.w * _MaskBlendIntensity;
    u_xlat16_13 = u_xlat16_35 + -1.0;
    u_xlat16_13 = _MaskBlendMethod * u_xlat16_13 + 1.0;
    u_xlat16_13 = u_xlat16_24 * u_xlat16_13 + (-u_xlat16_35);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_13 + u_xlat16_35;
    u_xlat16_0 = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat9.x = vs_TEXCOORD3.w;
    u_xlat9.y = vs_TEXCOORD4.w;
    u_xlat9.z = vs_TEXCOORD5.w;
    u_xlat11.xyz = (-u_xlat9.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat42 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat42 = inversesqrt(u_xlat42);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat9.xyz = (-u_xlat9.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat10 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat10);
    u_xlat16_35 = (-u_xlat16_0) + 1.0;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_36 = u_xlat1.y * u_xlat1.y;
    u_xlat16_36 = u_xlat1.x * u_xlat1.x + (-u_xlat16_36);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_36) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_36 = dot(u_xlat9.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat11.xyz * vec3(u_xlat42) + u_xlat9.xyz;
    u_xlat16_37 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_4.xyz = vec3(u_xlat16_37) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11.x = dot(u_xlat9.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_33 = u_xlat16_22 * u_xlat16_22;
    u_xlat1.x = u_xlat0.x * u_xlat16_33 + (-u_xlat0.x);
    u_xlat0.x = u_xlat1.x * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_33 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat16_22 = (-u_xlat16_22) * u_xlat16_22 + 1.0;
    u_xlat16_22 = u_xlat16_22 + u_xlat16_22;
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat16_35 = u_xlat11.x * u_xlat11.x;
    u_xlat16_35 = u_xlat11.x * u_xlat16_35;
    u_xlat16_35 = u_xlat11.x * u_xlat16_35;
    u_xlat16_35 = u_xlat11.x * u_xlat16_35;
    u_xlat16_11 = u_xlat16_35 * 0.959999979;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_22 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat16_2.xyz = u_xlat0.xxx * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_36) + u_xlat16_3.xyz;
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
  GpuProgramID 144421
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
 UsePass "miHoYo/Shadow/ShadowMapPass/LSPSMCULLNONE"
}
Fallback "Nature/Terrain/Diffuse"
}