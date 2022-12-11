//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Ice_DeferredUnlit" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[MHYToggle] _ReceiveShadow ("Receive Shadow", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
_ShadowIntensity ("Shadow Intensity", Range(0, 1)) = 1
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Highlight_Color ("Highlight_Color", Color) = (0.7334559,0.8970082,0.9779412,1)
_Fresnal_Scale ("Fresnal_Scale", Float) = 6.97
_Fresnal_Power ("Fresnal_Power", Float) = 5.68
_IceLightColor ("IceLightColor", Color) = (0.5073529,0.9692103,1,1)
_IceDarkColor ("IceDarkColor", Color) = (0.1098039,0.1686275,0.172549,1)
_CubeMap ("CubeMap", Cube) = "white" { }
_CubeMapBrightness ("CubeMapBrightness", Float) = 1
_Matcap ("Matcap", 2D) = "white" { }
_MatCapSize ("MatCapSize", Range(0, 2)) = 1
_MatCapColor ("MatCapColor", Color) = (1,1,1,1)
_NormalMap ("NormalMap", 2D) = "white" { }
_NormalIntensity ("NormalIntensity", Color) = (1,1,0.916,1)
[Toggle(_GRADIENTCOLORTOGGLE_ON)] _GradientColorToggle ("GradientColorToggle", Float) = 0
_GradientColor ("GradientColor", Color) = (0.2352941,0.4304256,1,0)
_GradientRange ("GradientRange", Float) = 1
_GradientOffset ("GradientOffset", Float) = 0
_DayColor ("DayColor", Color) = (1,1,1,1)
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 62673
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
float u_xlat22;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat21 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD1.xyz;
    u_xlat2.x = vs_TEXCOORD3.x;
    u_xlat2.y = vs_TEXCOORD5.x;
    u_xlat2.z = vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD3.y;
    u_xlat2.y = vs_TEXCOORD5.y;
    u_xlat2.z = vs_TEXCOORD4.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat22) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat21) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD3.z;
    u_xlat6.y = vs_TEXCOORD5.z;
    u_xlat6.z = vs_TEXCOORD4.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat21) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Power;
    u_xlat21 = exp2(u_xlat21);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat21) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = _ShadowIntensity;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    gl_Position = u_xlat1;
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat3.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD1.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat21;
float u_xlat22;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat21 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD1.xyz;
    u_xlat2.x = vs_TEXCOORD3.x;
    u_xlat2.y = vs_TEXCOORD5.x;
    u_xlat2.z = vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD3.y;
    u_xlat2.y = vs_TEXCOORD5.y;
    u_xlat2.z = vs_TEXCOORD4.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat22) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat21) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD3.z;
    u_xlat6.y = vs_TEXCOORD5.z;
    u_xlat6.z = vs_TEXCOORD4.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat21) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Power;
    u_xlat21 = exp2(u_xlat21);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat21) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = _ShadowIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_GRADIENTCOLORTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp float u_xlat10_8;
float u_xlat21;
float u_xlat22;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.x = vs_TEXCOORD2.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = vs_TEXCOORD3.x;
    u_xlat2.y = vs_TEXCOORD5.x;
    u_xlat2.z = vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD3.y;
    u_xlat2.y = vs_TEXCOORD5.y;
    u_xlat2.z = vs_TEXCOORD4.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = u_xlat2.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat22) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD3.z;
    u_xlat6.y = vs_TEXCOORD5.z;
    u_xlat6.z = vs_TEXCOORD4.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat22 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat22) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat22 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat10_8 = texture(_CubeMap, u_xlat8.xyz).x;
    u_xlat8.x = u_xlat10_8 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat8.xxx * u_xlat7.xyz + _IceDarkColor.xyz;
    u_xlat8.xyz = _GradientColor.xyz * u_xlat7.xyz + (-u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat21 = u_xlat1.x * u_xlat1.x;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Power;
    u_xlat21 = exp2(u_xlat21);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat21) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = _ShadowIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_GRADIENTCOLORTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_COLOR0;
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
    gl_Position = u_xlat1;
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat3.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD1.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _GradientColor;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp float u_xlat10_8;
float u_xlat21;
float u_xlat22;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.x = vs_TEXCOORD2.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = vs_TEXCOORD3.x;
    u_xlat2.y = vs_TEXCOORD5.x;
    u_xlat2.z = vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD3.y;
    u_xlat2.y = vs_TEXCOORD5.y;
    u_xlat2.z = vs_TEXCOORD4.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = u_xlat2.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat22) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD3.z;
    u_xlat6.y = vs_TEXCOORD5.z;
    u_xlat6.z = vs_TEXCOORD4.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat22 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat22) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat22 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat22)) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat10_8 = texture(_CubeMap, u_xlat8.xyz).x;
    u_xlat8.x = u_xlat10_8 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat8.xxx * u_xlat7.xyz + _IceDarkColor.xyz;
    u_xlat8.xyz = _GradientColor.xyz * u_xlat7.xyz + (-u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat21 = u_xlat1.x * u_xlat1.x;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Power;
    u_xlat21 = exp2(u_xlat21);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat21) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = _ShadowIntensity;
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
Keywords { "_GRADIENTCOLORTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_GRADIENTCOLORTOGGLE_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 116720
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
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
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
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
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 171464
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Fallback "Legacy Shaders/VertexLit"
CustomEditor "MiHoYoASEMaterialInspector"
}