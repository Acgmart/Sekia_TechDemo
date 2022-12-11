//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/MatCapObject_Mask" {
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
_DayColor ("DayColor", Color) = (1,1,1,1)
_MatCapTex ("MatCapTex", 2D) = "white" { }
_Mask ("Mask", 2D) = "white" { }
_MaskRDiffuseColor ("Mask(R)DiffuseColor", Color) = (1,1,1,1)
_MaskGColor ("Mask(G)Color", Color) = (1,1,1,1)
_MaskGColorScale ("Mask(G)ColorScale", Float) = 1
_MaskBUV ("Mask(B)UV", Vector) = (1,1,0,0)
_NormalTex ("NormalTex", 2D) = "white" { }
_NormalSale ("NormalSale", Float) = 1
_Spec_Color ("Spec_Color", Color) = (1,1,1,1)
_SpecColorScale ("SpecColorScale", Float) = 1
_SpecLight_Scale ("SpecLight_Scale", Float) = 0.7
_SpecLight_Threshold ("SpecLight_Threshold", Float) = 0.5
_FresPower ("FresPower", Range(0, 10)) = 9
_RimStr ("RimStr", Range(0, 1)) = 0
_CenterHaloScale ("CenterHaloScale", Float) = 0
_CenterHaloPos ("CenterHaloPos", Vector) = (0,0,0,0)
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 30697
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
in mediump vec4 in_TANGENT0;
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
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MaskRDiffuseColor;
uniform 	vec4 _Mask_ST;
uniform 	mediump vec4 _MaskGColor;
uniform 	mediump vec4 _MaskBUV;
uniform 	mediump float _MaskGColorScale;
uniform 	mediump vec3 _CenterHaloPos;
uniform 	mediump float _CenterHaloScale;
uniform 	mediump float _RimStr;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MatCapTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD6.y;
    u_xlat1.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD6.z;
    u_xlat1.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_9.x = (-u_xlat22) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = log2(u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_9.x * _FresPower;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat16_9.x>=0.579999983);
#else
    u_xlatb22 = u_xlat16_9.x>=0.579999983;
#endif
    u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
    u_xlat16_9.x = u_xlat16_9.x * 23.0 + 1.0;
    u_xlat16_16 = (u_xlatb22) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat3.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat3.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat0.xy = u_xlat3.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _MaskGColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _MaskRDiffuseColor.xyz;
    u_xlat16_6.xyz = (-u_xlat10_0.xyz) * _MaskRDiffuseColor.xyz + _MaskRDiffuseColor.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0.xy = texture(_Mask, u_xlat0.xy).xy;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * u_xlat16_9.xxx + (-u_xlat16_5.xyz);
    u_xlat16_9.xyz = u_xlat10_0.yyy * u_xlat16_9.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + u_xlat16_9.xyz;
    u_xlat0.xz = vec2(_Time.y * _MaskBUV.z, _Time.y * _MaskBUV.w);
    u_xlat0.xz = vs_TEXCOORD3.xy * _MaskBUV.xy + u_xlat0.xz;
    u_xlat10_0.x = texture(_Mask, u_xlat0.xz).z;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat10_0.y;
    u_xlat16_23 = u_xlat10_0.y + u_xlat10_0.y;
    u_xlat16_0.x = u_xlat16_0.x * 30.0;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _MaskGColor.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_MaskGColorScale) + u_xlat16_2.xyz;
    u_xlat3.xyz = vec3(vs_TEXCOORD7.x + _CenterHaloPos.xxyz.y, vs_TEXCOORD7.y + _CenterHaloPos.xxyz.z, vs_TEXCOORD7.z + float(_CenterHaloPos.z));
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + -0.340000004;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = min(u_xlat21, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat21) * _MaskGColor.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_CenterHaloScale) + u_xlat16_0.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_9.x = _RimStr * -5.0 + 5.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_9.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_23 * _RimStr + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(vec3(_RimStr, _RimStr, _RimStr)) * vec3(0.200000003, 0.200000003, 0.200000003) + _MaskGColor.xyz;
    u_xlat16_2.xyz = u_xlat16_9.xyz * u_xlat16_2.xxx;
    u_xlat16_23 = _RimStr * 6.0;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : 0.0;
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
in mediump vec4 in_TANGENT0;
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
    vs_TEXCOORD1.xyz = u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD2.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7 = in_POSITION0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Spec_Color;
uniform 	mediump float _SpecColorScale;
uniform 	mediump float _NormalSale;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _SpecLight_Scale;
uniform 	mediump float _SpecLight_Threshold;
uniform 	mediump float _FresPower;
uniform 	mediump vec4 _MaskRDiffuseColor;
uniform 	vec4 _Mask_ST;
uniform 	mediump vec4 _MaskGColor;
uniform 	mediump vec4 _MaskBUV;
uniform 	mediump float _MaskGColorScale;
uniform 	mediump vec3 _CenterHaloPos;
uniform 	mediump float _CenterHaloScale;
uniform 	mediump float _RimStr;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MatCapTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalSale, _NormalSale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD6.y;
    u_xlat1.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD6.z;
    u_xlat1.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x * _SpecLight_Scale + (-_SpecLight_Threshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_9.x = (-u_xlat22) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = log2(u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_9.x * _FresPower;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat16_9.x>=0.579999983);
#else
    u_xlatb22 = u_xlat16_9.x>=0.579999983;
#endif
    u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
    u_xlat16_9.x = u_xlat16_9.x * 23.0 + 1.0;
    u_xlat16_16 = (u_xlatb22) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat3.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_MatrixV[0].xyz);
    u_xlat3.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_MatrixV[1].xyz);
    u_xlat0.xy = u_xlat3.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCapTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _MaskGColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _MaskRDiffuseColor.xyz;
    u_xlat16_6.xyz = (-u_xlat10_0.xyz) * _MaskRDiffuseColor.xyz + _MaskRDiffuseColor.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0.xy = texture(_Mask, u_xlat0.xy).xy;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * u_xlat16_9.xxx + (-u_xlat16_5.xyz);
    u_xlat16_9.xyz = u_xlat10_0.yyy * u_xlat16_9.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = _Spec_Color.xyz * vec3(_SpecColorScale);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + u_xlat16_9.xyz;
    u_xlat0.xz = vec2(_Time.y * _MaskBUV.z, _Time.y * _MaskBUV.w);
    u_xlat0.xz = vs_TEXCOORD3.xy * _MaskBUV.xy + u_xlat0.xz;
    u_xlat10_0.x = texture(_Mask, u_xlat0.xz).z;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat10_0.y;
    u_xlat16_23 = u_xlat10_0.y + u_xlat10_0.y;
    u_xlat16_0.x = u_xlat16_0.x * 30.0;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _MaskGColor.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_MaskGColorScale) + u_xlat16_2.xyz;
    u_xlat3.xyz = vec3(vs_TEXCOORD7.x + _CenterHaloPos.xxyz.y, vs_TEXCOORD7.y + _CenterHaloPos.xxyz.z, vs_TEXCOORD7.z + float(_CenterHaloPos.z));
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 + -0.340000004;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = min(u_xlat21, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat21) * _MaskGColor.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_CenterHaloScale) + u_xlat16_0.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_9.x = _RimStr * -5.0 + 5.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_9.x;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_23 * _RimStr + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(vec3(_RimStr, _RimStr, _RimStr)) * vec3(0.200000003, 0.200000003, 0.200000003) + _MaskGColor.xyz;
    u_xlat16_2.xyz = u_xlat16_9.xyz * u_xlat16_2.xxx;
    u_xlat16_23 = _RimStr * 6.0;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * _DayColor.xyz;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : 0.0;
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
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 111208
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
  GpuProgramID 161519
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