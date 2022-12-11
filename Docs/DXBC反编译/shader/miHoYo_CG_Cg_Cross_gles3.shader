//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/Cg_Cross" {
Properties {
_BaseTexColor ("BaseTexColor", Color) = (1,1,1,1)
_ShapeChange ("ShapeChange", Range(-5, 5)) = 0
[MHYToggle] _ShapeChangeInCustomData1 ("ShapeChangeInCustomData1", Float) = 0
_BaseTex ("BaseTex", 2D) = "white" { }
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
[Enum(R,0,G,1,B,2,A,3)] _BaseColorChannelSwitch ("BaseColorChannelSwitch", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _BaseAlphaChannelSwitch ("BaseAlphaChannelSwitch", Float) = 0
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 20097
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
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
float u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_10;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat16_1.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x + -0.5;
    u_xlat16_1.x = u_xlat16_1.x * -2.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_4.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlatb2 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_10 = (u_xlatb2.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = vec2(u_xlat16_10) * u_xlat16_4.xy;
    u_xlat16_1.xy = u_xlat16_4.xy * u_xlat16_1.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat11 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8 = (u_xlatb2.z) ? u_xlat1.z : u_xlat11;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat8;
    u_xlat2 = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat2 = u_xlat2 * _BaseTexColor.w;
    u_xlat2 = u_xlat2 * _AlphaBrightness;
    u_xlat0.w = u_xlat2 * vs_COLOR0.w;
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
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
float u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_10;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat16_1.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x + -0.5;
    u_xlat16_1.x = u_xlat16_1.x * -2.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_4.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlatb2 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_10 = (u_xlatb2.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = vec2(u_xlat16_10) * u_xlat16_4.xy;
    u_xlat16_1.xy = u_xlat16_4.xy * u_xlat16_1.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat11 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8 = (u_xlatb2.z) ? u_xlat1.z : u_xlat11;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat8;
    u_xlat2 = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat2 = u_xlat2 * _BaseTexColor.w;
    u_xlat2 = u_xlat2 * _AlphaBrightness;
    u_xlat0.w = u_xlat2 * vs_COLOR0.w;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb2;
float u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_7;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.x = (u_xlatb0.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_4.xy);
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x + -0.5;
    u_xlat16_4.x = u_xlat16_4.x * -2.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_7.x = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7.x;
    u_xlat16_7.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xz = u_xlat16_1.xx * u_xlat16_7.xy;
    u_xlat16_1.xy = u_xlat16_1.xz * u_xlat16_4.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0.x = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat0.x;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat3;
    u_xlat3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat3;
    u_xlat3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat3;
    u_xlat0.xzw = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat0.xzw * vs_COLOR0.xyz;
    u_xlat0.x = u_xlat3 * _BaseTexColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * vs_COLOR0.w;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb2;
float u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_7;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.x = (u_xlatb0.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_4.xy);
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x + -0.5;
    u_xlat16_4.x = u_xlat16_4.x * -2.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_7.x = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7.x;
    u_xlat16_7.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xz = u_xlat16_1.xx * u_xlat16_7.xy;
    u_xlat16_1.xy = u_xlat16_1.xz * u_xlat16_4.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0.x = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat0.x;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat3;
    u_xlat3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat3;
    u_xlat3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat3;
    u_xlat0.xzw = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat0.xzw * vs_COLOR0.xyz;
    u_xlat0.x = u_xlat3 * _BaseTexColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * vs_COLOR0.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
float u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_10;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat16_1.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x + -0.5;
    u_xlat16_1.x = u_xlat16_1.x * -2.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_4.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlatb2 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_10 = (u_xlatb2.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = vec2(u_xlat16_10) * u_xlat16_4.xy;
    u_xlat16_1.xy = u_xlat16_4.xy * u_xlat16_1.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat11 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8 = (u_xlatb2.z) ? u_xlat1.z : u_xlat11;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat8;
    u_xlat2 = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat2 = u_xlat2 * _BaseTexColor.w;
    u_xlat2 = u_xlat2 * _AlphaBrightness;
    u_xlat0.w = u_xlat2 * vs_COLOR0.w;
    SV_Target0 = u_xlat0;
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
float u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_4;
float u_xlat5;
float u_xlat8;
mediump float u_xlat16_10;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat16_1.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x + -0.5;
    u_xlat16_1.x = u_xlat16_1.x * -2.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_4.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlatb2 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_10 = (u_xlatb2.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = vec2(u_xlat16_10) * u_xlat16_4.xy;
    u_xlat16_1.xy = u_xlat16_4.xy * u_xlat16_1.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat11 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8 = (u_xlatb2.z) ? u_xlat1.z : u_xlat11;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat8;
    u_xlat2 = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat2 = u_xlat2 * _BaseTexColor.w;
    u_xlat2 = u_xlat2 * _AlphaBrightness;
    u_xlat0.w = u_xlat2 * vs_COLOR0.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb2;
float u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_7;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.x = (u_xlatb0.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_4.xy);
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x + -0.5;
    u_xlat16_4.x = u_xlat16_4.x * -2.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_7.x = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7.x;
    u_xlat16_7.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xz = u_xlat16_1.xx * u_xlat16_7.xy;
    u_xlat16_1.xy = u_xlat16_1.xz * u_xlat16_4.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0.x = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat0.x;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat3;
    u_xlat3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat3;
    u_xlat3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat3;
    u_xlat0.xzw = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat0.xzw * vs_COLOR0.xyz;
    u_xlat0.x = u_xlat3 * _BaseTexColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * vs_COLOR0.w;
    SV_Target0 = u_xlat1;
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _BaseColorChannelSwitch;
uniform 	mediump float _ShapeChangeInCustomData1;
uniform 	mediump float _ShapeChange;
uniform 	mediump vec4 _BaseTexColor;
uniform 	mediump float _ColorBrightness;
uniform 	mediump float _BaseAlphaChannelSwitch;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb2;
float u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_7;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0 = equal(vec4(_ShapeChangeInCustomData1, _BaseColorChannelSwitch, _BaseColorChannelSwitch, _BaseColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat16_1.x = (u_xlatb0.x) ? vs_TEXCOORD1.x : _ShapeChange;
    u_xlat16_4.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat16_4.x = dot(u_xlat16_4.xy, u_xlat16_4.xy);
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x + -0.5;
    u_xlat16_4.x = u_xlat16_4.x * -2.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlat16_7.x = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7.x;
    u_xlat16_7.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xz = u_xlat16_1.xx * u_xlat16_7.xy;
    u_xlat16_1.xy = u_xlat16_1.xz * u_xlat16_4.xx + vs_TEXCOORD0.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseColorChannelSwitch==3.0);
#else
    u_xlatb0.x = _BaseColorChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat0.x;
    u_xlatb2 = equal(vec4(vec4(_BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch, _BaseAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat1.z : u_xlat3;
    u_xlat3 = (u_xlatb2.y) ? u_xlat1.y : u_xlat3;
    u_xlat3 = (u_xlatb2.x) ? u_xlat1.x : u_xlat3;
    u_xlat0.xzw = u_xlat0.xxx * _BaseTexColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat0.xzw * vs_COLOR0.xyz;
    u_xlat0.x = u_xlat3 * _BaseTexColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * vs_COLOR0.w;
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
}
CustomEditor "MiHoYoASEMaterialInspector"
}