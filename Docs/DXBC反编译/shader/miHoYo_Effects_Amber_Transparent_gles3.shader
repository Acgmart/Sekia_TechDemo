//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Amber_Transparent" {
Properties {
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_ElementMask ("ElementMask", 2D) = "white" { }
_CubeMap ("CubeMap", Cube) = "white" { }
_CubeMapBrightness ("CubeMapBrightness", Float) = 4
_CubeMaskTex ("CubeMaskTex", 2D) = "white" { }
_CubeMapIntensity ("CubeMapIntensity", Range(0, 1)) = 0.007757068
_Fresnal_Power ("Fresnal_Power", Float) = 3
_Fresnal_Scale ("Fresnal_Scale", Float) = 1
_Highlight_Color ("Highlight_Color", Color) = (0.7334559,0.8970082,0.9779412,0)
_BumpTex ("BumpTex", 2D) = "white" { }
_BumpOffsetHeight ("BumpOffsetHeight", Float) = 14.89
_BumpTexIntensity ("BumpTexIntensity", Range(0, 2)) = 1
_MainNormalIntensity ("MainNormalIntensity", Color) = (1,1,1,0)
_LightColor ("LightColor", Color) = (0.5073529,0.9692103,1,0)
_DarkColor ("DarkColor", Color) = (0.05482266,0.1121853,0.1911765,0)
_GlobalBightness ("GlobalBightness", Float) = 1
_EmissiveIntensity ("EmissiveIntensity", Range(0, 1)) = 1
[MHYToggle] _TillingNormalToggle ("TillingNormalToggle", Float) = 1
_NormalMap ("NormalMap", 2D) = "white" { }
_TillingNormal ("TillingNormal", 2D) = "white" { }
_NormalIntensity ("NormalIntensity", Color) = (0.659,0.672,1,0)
_EdgeColor ("EdgeColor", Color) = (0,0,0,0)
_EdgePower ("EdgePower", Float) = 2.41
_EdgeWidth ("EdgeWidth", Float) = 3.39
_ElementPatternIntensity ("ElementPatternIntensity", Float) = 0
_ElementPatternColor ("ElementPatternColor", Color) = (0,0,0,0)
_IceCenterTransparency ("IceCenterTransparency", Float) = 0.1
_TransparencyExp ("TransparencyExp", Float) = 3.34
_IceTransparency ("IceTransparency", Float) = 2
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 380
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
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
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
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
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat14;
vec2 u_xlat26;
float u_xlat36;
float u_xlat37;
bool u_xlatb37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_40;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat26.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat26.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb37 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb37){
        u_xlat26.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat26.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat37 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Power;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat26.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat39 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat26.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat26.x = inversesqrt(u_xlat26.x);
    u_xlat6.xyz = u_xlat26.xxx * u_xlat6.xyz;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = (-u_xlat26.x) + 1.0;
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat39 = log2(u_xlat38);
    u_xlat39 = u_xlat39 * _EdgePower;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat14 = (-u_xlat39) + 1.0;
    u_xlat2.x = u_xlat14 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat37) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat37 = max(u_xlat38, _IceCenterTransparency);
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _TransparencyExp;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat16_5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_40 = log2(u_xlat16_5.w);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.y;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.x;
    u_xlat16_9.xyz = u_xlat16_5.xyz * vec3(u_xlat16_40);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_45 = u_xlat10_4.w + -1.0;
    u_xlat16_45 = unity_SpecCube0_HDR.w * u_xlat16_45 + 1.0;
    u_xlat16_45 = log2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.y;
    u_xlat16_45 = exp2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.x;
    u_xlat16_10.xyz = u_xlat10_4.xyz * vec3(u_xlat16_45);
    u_xlat16_11.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat26.x = u_xlat26.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26.x = min(max(u_xlat26.x, 0.0), 1.0);
#else
    u_xlat26.x = clamp(u_xlat26.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_45 = (-u_xlat26.x) + 1.0;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_9.xyz * vec3(u_xlat16_45) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat37;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
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
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec4 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_38;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_38 = u_xlat4.y * u_xlat4.y;
    u_xlat16_38 = u_xlat4.x * u_xlat4.x + (-u_xlat16_38);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_38) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_38 = log2(u_xlat16_6.w);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.y;
    u_xlat16_38 = exp2(u_xlat16_38);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.x;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
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
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2 = vec4(u_xlat22) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.w = u_xlat0.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat2.w;
    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.wwzw + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat0.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat0.x;
    vs_TEXCOORD3.x = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat14;
vec2 u_xlat26;
float u_xlat36;
float u_xlat37;
bool u_xlatb37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_40;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat26.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat26.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb37 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb37){
        u_xlat26.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat26.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat37 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Power;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat26.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat39 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat26.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat26.x = inversesqrt(u_xlat26.x);
    u_xlat6.xyz = u_xlat26.xxx * u_xlat6.xyz;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = (-u_xlat26.x) + 1.0;
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat39 = log2(u_xlat38);
    u_xlat39 = u_xlat39 * _EdgePower;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat14 = (-u_xlat39) + 1.0;
    u_xlat2.x = u_xlat14 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat37) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat37 = max(u_xlat38, _IceCenterTransparency);
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _TransparencyExp;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat16_5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_40 = log2(u_xlat16_5.w);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.y;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.x;
    u_xlat16_9.xyz = u_xlat16_5.xyz * vec3(u_xlat16_40);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_45 = u_xlat10_4.w + -1.0;
    u_xlat16_45 = unity_SpecCube0_HDR.w * u_xlat16_45 + 1.0;
    u_xlat16_45 = log2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.y;
    u_xlat16_45 = exp2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.x;
    u_xlat16_10.xyz = u_xlat10_4.xyz * vec3(u_xlat16_45);
    u_xlat16_11.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat26.x = u_xlat26.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26.x = min(max(u_xlat26.x, 0.0), 1.0);
#else
    u_xlat26.x = clamp(u_xlat26.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_45 = (-u_xlat26.x) + 1.0;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_9.xyz * vec3(u_xlat16_45) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat37;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat4 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat0.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat0.x;
    vs_TEXCOORD3.x = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec4 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_38;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_38 = u_xlat4.y * u_xlat4.y;
    u_xlat16_38 = u_xlat4.x * u_xlat4.x + (-u_xlat16_38);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_38) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_38 = log2(u_xlat16_6.w);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.y;
    u_xlat16_38 = exp2(u_xlat16_38);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.x;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat22;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat7.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat7.y;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.w = u_xlat7.z;
    vs_TEXCOORD3.z = u_xlat2.w;
    u_xlat1 = (-u_xlat7.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat7.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat7.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.wwzw + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
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
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11.x = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat11.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat11.x = texture(_CameraDepthTexture, u_xlat11.xz).x;
    u_xlat11.x = _ZBufferParams.z * u_xlat11.x + _ZBufferParams.w;
    u_xlat11.x = float(1.0) / u_xlat11.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat11.x;
    u_xlat11.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat29 = (-u_xlat11.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat29 + u_xlat11.x;
    u_xlat28 = u_xlat28 * u_xlat2.x;
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.x = u_xlat2.z;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.z = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD2.z = u_xlat3.y;
    vs_TEXCOORD3.z = u_xlat3.w;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5 = u_xlat3.y * u_xlat3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat3.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat3.ywzx * u_xlat3;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13.x = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat13.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat13.x = texture(_CameraDepthTexture, u_xlat13.xz).x;
    u_xlat13.x = _ZBufferParams.z * u_xlat13.x + _ZBufferParams.w;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat13.x;
    u_xlat13.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat35 = (-u_xlat13.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat35 + u_xlat13.x;
    u_xlat34 = u_xlat34 * u_xlat2.x;
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
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
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat36;
float u_xlat37;
bool u_xlatb37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_40;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat26.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat26.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb37 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb37){
        u_xlat26.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat26.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat37 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Power;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat26.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat39 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat26.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat26.x = inversesqrt(u_xlat26.x);
    u_xlat6.xyz = u_xlat26.xxx * u_xlat6.xyz;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = (-u_xlat26.x) + 1.0;
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat39 = log2(u_xlat38);
    u_xlat39 = u_xlat39 * _EdgePower;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat14.x = (-u_xlat39) + 1.0;
    u_xlat2.x = u_xlat14.x * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat37) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat37 = max(u_xlat38, _IceCenterTransparency);
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _TransparencyExp;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat14.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat14.x = texture(_CameraDepthTexture, u_xlat14.xz).x;
    u_xlat14.x = _ZBufferParams.z * u_xlat14.x + _ZBufferParams.w;
    u_xlat14.x = float(1.0) / u_xlat14.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat14.x;
    u_xlat14.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat14.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat38 + u_xlat14.x;
    u_xlat37 = u_xlat37 * u_xlat2.x;
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat16_5 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_40 = log2(u_xlat16_5.w);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.y;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.x;
    u_xlat16_9.xyz = u_xlat16_5.xyz * vec3(u_xlat16_40);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_45 = u_xlat10_4.w + -1.0;
    u_xlat16_45 = unity_SpecCube0_HDR.w * u_xlat16_45 + 1.0;
    u_xlat16_45 = log2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.y;
    u_xlat16_45 = exp2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.x;
    u_xlat16_10.xyz = u_xlat10_4.xyz * vec3(u_xlat16_45);
    u_xlat16_11.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat26.x = u_xlat26.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26.x = min(max(u_xlat26.x, 0.0), 1.0);
#else
    u_xlat26.x = clamp(u_xlat26.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_45 = (-u_xlat26.x) + 1.0;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_9.xyz * vec3(u_xlat16_45) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat37;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
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
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec4 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_38;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13.x = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat13.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat13.x = texture(_CameraDepthTexture, u_xlat13.xz).x;
    u_xlat13.x = _ZBufferParams.z * u_xlat13.x + _ZBufferParams.w;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat13.x;
    u_xlat13.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat35 = (-u_xlat13.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat35 + u_xlat13.x;
    u_xlat34 = u_xlat34 * u_xlat2.x;
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_38 = u_xlat4.y * u_xlat4.y;
    u_xlat16_38 = u_xlat4.x * u_xlat4.x + (-u_xlat16_38);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_38) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_38 = log2(u_xlat16_6.w);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.y;
    u_xlat16_38 = exp2(u_xlat16_38);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.x;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
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
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11.x = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat11.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat11.x = texture(_CameraDepthTexture, u_xlat11.xz).x;
    u_xlat11.x = _ZBufferParams.z * u_xlat11.x + _ZBufferParams.w;
    u_xlat11.x = float(1.0) / u_xlat11.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat11.x;
    u_xlat11.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat29 = (-u_xlat11.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat29 + u_xlat11.x;
    u_xlat28 = u_xlat28 * u_xlat2.x;
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat23;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD1.x = u_xlat2.z;
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3 = vec4(u_xlat23) * u_xlat3.xyzz;
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.w = u_xlat0.x;
    vs_TEXCOORD1.z = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat3.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat3.w;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat21 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat3.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat3.ywzx * u_xlat3;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13.x = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat13.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat13.x = texture(_CameraDepthTexture, u_xlat13.xz).x;
    u_xlat13.x = _ZBufferParams.z * u_xlat13.x + _ZBufferParams.w;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat13.x;
    u_xlat13.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat35 = (-u_xlat13.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat35 + u_xlat13.x;
    u_xlat34 = u_xlat34 * u_xlat2.x;
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
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
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat5.x;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat5.y;
    vs_TEXCOORD3.w = u_xlat5.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11.x = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat11.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat11.x = texture(_CameraDepthTexture, u_xlat11.xz).x;
    u_xlat11.x = _ZBufferParams.z * u_xlat11.x + _ZBufferParams.w;
    u_xlat11.x = float(1.0) / u_xlat11.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat11.x;
    u_xlat11.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat29 = (-u_xlat11.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat29 + u_xlat11.x;
    u_xlat28 = u_xlat28 * u_xlat2.x;
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat3.x;
    vs_TEXCOORD1.w = u_xlat7.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.w = u_xlat7.y;
    vs_TEXCOORD3.w = u_xlat7.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD2.z = u_xlat3.y;
    vs_TEXCOORD3.z = u_xlat3.w;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat16_5 = u_xlat3.y * u_xlat3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat3.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat3.ywzx * u_xlat3;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13.x = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat13.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat13.x = texture(_CameraDepthTexture, u_xlat13.xz).x;
    u_xlat13.x = _ZBufferParams.z * u_xlat13.x + _ZBufferParams.w;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat13.x;
    u_xlat13.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat35 = (-u_xlat13.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat35 + u_xlat13.x;
    u_xlat34 = u_xlat34 * u_xlat2.x;
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat5 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xzw;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat3.zxy * u_xlat0.yzx + (-u_xlat4.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat0.z;
    vs_TEXCOORD1.z = u_xlat3.y;
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat0.x;
    vs_TEXCOORD3.x = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat3.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat36;
float u_xlat37;
bool u_xlatb37;
float u_xlat38;
float u_xlat39;
mediump float u_xlat16_40;
mediump float u_xlat16_45;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat26.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat26.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb37 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb37){
        u_xlat26.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat26.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat37 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Power;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat26.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat39 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat39);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat26.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat26.x = inversesqrt(u_xlat26.x);
    u_xlat6.xyz = u_xlat26.xxx * u_xlat6.xyz;
    u_xlat26.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = (-u_xlat26.x) + 1.0;
    u_xlat38 = max(u_xlat38, 9.99999975e-05);
    u_xlat39 = log2(u_xlat38);
    u_xlat39 = u_xlat39 * _EdgePower;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat14.x = (-u_xlat39) + 1.0;
    u_xlat2.x = u_xlat14.x * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = inversesqrt(u_xlat39);
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat37) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat37 = max(u_xlat38, _IceCenterTransparency);
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _TransparencyExp;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = u_xlat37 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat14.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat14.x = texture(_CameraDepthTexture, u_xlat14.xz).x;
    u_xlat14.x = _ZBufferParams.z * u_xlat14.x + _ZBufferParams.w;
    u_xlat14.x = float(1.0) / u_xlat14.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat14.x;
    u_xlat14.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat38 = (-u_xlat14.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat38 + u_xlat14.x;
    u_xlat37 = u_xlat37 * u_xlat2.x;
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat16_5 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_40 = log2(u_xlat16_5.w);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.y;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * unity_Lightmap_HDR.x;
    u_xlat16_9.xyz = u_xlat16_5.xyz * vec3(u_xlat16_40);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_45 = u_xlat10_4.w + -1.0;
    u_xlat16_45 = unity_SpecCube0_HDR.w * u_xlat16_45 + 1.0;
    u_xlat16_45 = log2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.y;
    u_xlat16_45 = exp2(u_xlat16_45);
    u_xlat16_45 = u_xlat16_45 * unity_SpecCube0_HDR.x;
    u_xlat16_10.xyz = u_xlat10_4.xyz * vec3(u_xlat16_45);
    u_xlat16_11.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat26.x = u_xlat26.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26.x = min(max(u_xlat26.x, 0.0), 1.0);
#else
    u_xlat26.x = clamp(u_xlat26.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_10.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_45 = (-u_xlat26.x) + 1.0;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
    u_xlat16_45 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_9.xyz * vec3(u_xlat16_45) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat37;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat5 = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xzw;
    u_xlat4.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat3.zxy * u_xlat0.yzx + (-u_xlat4.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat0.z;
    vs_TEXCOORD1.z = u_xlat3.y;
    vs_TEXCOORD1.w = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat0.x;
    vs_TEXCOORD3.x = u_xlat0.y;
    vs_TEXCOORD2.z = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat3.x;
    vs_TEXCOORD2.w = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat1.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec4 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_38;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13.x = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat13.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat13.x = texture(_CameraDepthTexture, u_xlat13.xz).x;
    u_xlat13.x = _ZBufferParams.z * u_xlat13.x + _ZBufferParams.w;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat13.x;
    u_xlat13.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat35 = (-u_xlat13.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat35 + u_xlat13.x;
    u_xlat34 = u_xlat34 * u_xlat2.x;
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_38 = u_xlat4.y * u_xlat4.y;
    u_xlat16_38 = u_xlat4.x * u_xlat4.x + (-u_xlat16_38);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_38) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_38 = log2(u_xlat16_6.w);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.y;
    u_xlat16_38 = exp2(u_xlat16_38);
    u_xlat16_38 = u_xlat16_38 * unity_Lightmap_HDR.x;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
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
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat3.z;
    vs_TEXCOORD1.z = u_xlat2.y;
    vs_TEXCOORD1.w = u_xlat5.x;
    vs_TEXCOORD2.x = u_xlat3.x;
    vs_TEXCOORD3.x = u_xlat3.y;
    vs_TEXCOORD2.z = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD2.w = u_xlat5.y;
    vs_TEXCOORD3.w = u_xlat5.z;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = (-u_xlat20.x) + 1.0;
    u_xlat29 = max(u_xlat29, 9.99999975e-05);
    u_xlat30 = log2(u_xlat29);
    u_xlat30 = u_xlat30 * _EdgePower;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = u_xlat30 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11.x = (-u_xlat30) + 1.0;
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat7.xyz) + _ElementPatternColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat7.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat7.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat28 = max(u_xlat29, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat11.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat11.x = texture(_CameraDepthTexture, u_xlat11.xz).x;
    u_xlat11.x = _ZBufferParams.z * u_xlat11.x + _ZBufferParams.w;
    u_xlat11.x = float(1.0) / u_xlat11.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat11.x;
    u_xlat11.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat29 = (-u_xlat11.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat29 + u_xlat11.x;
    u_xlat28 = u_xlat28 * u_xlat2.x;
    u_xlat16_4.x = dot((-u_xlat1.xyz), u_xlat6.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = u_xlat6.xyz * (-u_xlat16_4.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_4.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat16_5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat20.x = u_xlat20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat20.x = min(max(u_xlat20.x, 0.0), 1.0);
#else
    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_32 = (-u_xlat20.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * 2.23517418e-08 + 0.0399999991;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD1.y = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat3.x;
    vs_TEXCOORD1.w = u_xlat7.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.w = u_xlat7.y;
    vs_TEXCOORD2.y = u_xlat4.y;
    vs_TEXCOORD3.y = u_xlat4.z;
    vs_TEXCOORD2.z = u_xlat3.y;
    vs_TEXCOORD3.w = u_xlat7.z;
    vs_TEXCOORD3.z = u_xlat3.w;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat0.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = (-u_xlat7.xxxx) + unity_4LightPosX0;
    u_xlat2 = (-u_xlat7.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat7.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat3.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat3.ywzx * u_xlat3;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat13;
vec2 u_xlat24;
float u_xlat33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
float u_xlat36;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat24.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat24.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb34 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb34){
        u_xlat24.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat24.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat34 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat34 = (-u_xlat34) + 1.0;
    u_xlat34 = max(u_xlat34, 9.99999975e-05);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Power;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat24.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat36 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat36);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat24.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat24.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat24.x = inversesqrt(u_xlat24.x);
    u_xlat4.xyz = u_xlat24.xxx * u_xlat6.xyz;
    u_xlat24.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat35 = (-u_xlat24.x) + 1.0;
    u_xlat35 = max(u_xlat35, 9.99999975e-05);
    u_xlat36 = log2(u_xlat35);
    u_xlat36 = u_xlat36 * _EdgePower;
    u_xlat36 = exp2(u_xlat36);
    u_xlat36 = u_xlat36 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat13.x = (-u_xlat36) + 1.0;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _EdgeColor.xyz;
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_2 = texture(_ElementMask, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat6.xyz) + _ElementPatternColor.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat3.xyz = u_xlat7.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat3.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_2 = texture(_CubeMaskTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat6.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + u_xlat6.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat34) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat34 = max(u_xlat35, _IceCenterTransparency);
    u_xlat34 = min(u_xlat34, 1.0);
    u_xlat34 = log2(u_xlat34);
    u_xlat34 = u_xlat34 * _TransparencyExp;
    u_xlat34 = exp2(u_xlat34);
    u_xlat34 = u_xlat34 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD4.w + 9.99999996e-12;
    u_xlat13.xz = vs_TEXCOORD4.xy / u_xlat2.xx;
    u_xlat13.x = texture(_CameraDepthTexture, u_xlat13.xz).x;
    u_xlat13.x = _ZBufferParams.z * u_xlat13.x + _ZBufferParams.w;
    u_xlat13.x = float(1.0) / u_xlat13.x;
    u_xlat2.x = (-u_xlat2.x) + u_xlat13.x;
    u_xlat13.x = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat35 = (-u_xlat13.x) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat35 + u_xlat13.x;
    u_xlat34 = u_xlat34 * u_xlat2.x;
    u_xlat16_5.x = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat4.xyz * (-u_xlat16_5.xxx) + (-u_xlat1.xyz);
    u_xlat4.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_41 = u_xlat10_5.w + -1.0;
    u_xlat16_41 = unity_SpecCube0_HDR.w * u_xlat16_41 + 1.0;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.y;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(u_xlat16_41);
    u_xlat16_10.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat24.x = u_xlat24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat16_41 = (-u_xlat24.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 2.23517418e-08 + 0.0399999991;
    u_xlat0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity)) + u_xlat0.xyz;
    SV_Target0.w = u_xlat34;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 99596
Program "vp" {
SubProgram "gles3 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat13;
vec2 u_xlat23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
float u_xlat33;
lowp float u_xlat10_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat3.xy = u_xlat2.yy * vs_TEXCOORD2.xy;
    u_xlat3.xy = vs_TEXCOORD1.xy * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = vs_TEXCOORD3.xy * u_xlat2.zz + u_xlat3.xy;
    u_xlat23.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat23.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb31 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat23.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_4.xyz = texture(_TillingNormal, u_xlat23.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat4.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Power;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat23.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat32 = _BumpOffsetHeight + -1.0;
    u_xlat3.xy = u_xlat16_5.xy * _MainNormalIntensity.xy + u_xlat3.xy;
    u_xlat3.xy = vec2(u_xlat32) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat23.xy;
    u_xlat7.x = vs_TEXCOORD1.z;
    u_xlat7.y = vs_TEXCOORD2.z;
    u_xlat7.z = vs_TEXCOORD3.z;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat32 = (-u_xlat32) + 1.0;
    u_xlat32 = max(u_xlat32, 9.99999975e-05);
    u_xlat23.x = log2(u_xlat32);
    u_xlat23.x = u_xlat23.x * _EdgePower;
    u_xlat23.x = exp2(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat10_3 = texture(_BumpTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat23.x) + 1.0;
    u_xlat3.x = u_xlat13 * u_xlat3.x;
    u_xlat8.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyw = u_xlat3.xxx * u_xlat8.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat3.xyw) + _EdgeColor.xyz;
    u_xlat3.xyz = u_xlat23.xxx * u_xlat8.xyz + u_xlat3.xyw;
    u_xlat8.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_33 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat3.xyz) + _ElementPatternColor.xyz;
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat8.xyz + u_xlat3.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat4.xyz = u_xlat4.xyz * _NormalIntensity.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat9.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat9.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat33 = dot((-u_xlat2.xyz), u_xlat9.xyz);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat4.xyz = u_xlat9.xyz * (-vec3(u_xlat33)) + (-u_xlat2.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_CubeMap, u_xlat4.xyz).xyz;
    u_xlat10_33 = texture(_CubeMaskTex, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _CubeMapIntensity;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_CubeMapBrightness) + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat31) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat31 = max(u_xlat32, _IceCenterTransparency);
    u_xlat31 = min(u_xlat31, 1.0);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _TransparencyExp;
    u_xlat31 = exp2(u_xlat31);
    u_xlat4.w = u_xlat31 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.w = min(max(u_xlat4.w, 0.0), 1.0);
#else
    u_xlat4.w = clamp(u_xlat4.w, 0.0, 1.0);
#endif
    u_xlat8.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = texture(_LightTexture0, vec2(u_xlat31)).w;
    u_xlat16_5.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
lowp float u_xlat10_30;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat20.x = (-u_xlat20.x) + 1.0;
    u_xlat20.x = max(u_xlat20.x, 9.99999975e-05);
    u_xlat29 = log2(u_xlat20.x);
    u_xlat29 = u_xlat29 * _EdgePower;
    u_xlat29 = exp2(u_xlat29);
    u_xlat29 = u_xlat29 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat29) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat2.xyw = vec3(u_xlat29) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_30 = texture(_ElementMask, u_xlat7.xy).x;
    u_xlat30 = u_xlat10_30 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat2.xyw) + _ElementPatternColor.xyz;
    u_xlat2.xyw = vec3(u_xlat30) * u_xlat7.xyz + u_xlat2.xyw;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat1.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat10_3.x = texture(_CubeMaskTex, u_xlat7.xy).x;
    u_xlat3.x = u_xlat10_3.x * _CubeMapIntensity;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapBrightness) + (-u_xlat2.xyw);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat1.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat28 = max(u_xlat20.x, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat2.w = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat13;
vec2 u_xlat23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
float u_xlat33;
lowp float u_xlat10_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat3.xy = u_xlat2.yy * vs_TEXCOORD2.xy;
    u_xlat3.xy = vs_TEXCOORD1.xy * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = vs_TEXCOORD3.xy * u_xlat2.zz + u_xlat3.xy;
    u_xlat23.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat23.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb31 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat23.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_4.xyz = texture(_TillingNormal, u_xlat23.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat4.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Power;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat23.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat32 = _BumpOffsetHeight + -1.0;
    u_xlat3.xy = u_xlat16_5.xy * _MainNormalIntensity.xy + u_xlat3.xy;
    u_xlat3.xy = vec2(u_xlat32) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat23.xy;
    u_xlat7.x = vs_TEXCOORD1.z;
    u_xlat7.y = vs_TEXCOORD2.z;
    u_xlat7.z = vs_TEXCOORD3.z;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat32 = (-u_xlat32) + 1.0;
    u_xlat32 = max(u_xlat32, 9.99999975e-05);
    u_xlat23.x = log2(u_xlat32);
    u_xlat23.x = u_xlat23.x * _EdgePower;
    u_xlat23.x = exp2(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat10_3 = texture(_BumpTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat23.x) + 1.0;
    u_xlat3.x = u_xlat13 * u_xlat3.x;
    u_xlat8.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyw = u_xlat3.xxx * u_xlat8.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat3.xyw) + _EdgeColor.xyz;
    u_xlat3.xyz = u_xlat23.xxx * u_xlat8.xyz + u_xlat3.xyw;
    u_xlat8.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_33 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat3.xyz) + _ElementPatternColor.xyz;
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat8.xyz + u_xlat3.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat4.xyz = u_xlat4.xyz * _NormalIntensity.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat9.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat9.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat33 = dot((-u_xlat2.xyz), u_xlat9.xyz);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat4.xyz = u_xlat9.xyz * (-vec3(u_xlat33)) + (-u_xlat2.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_CubeMap, u_xlat4.xyz).xyz;
    u_xlat10_33 = texture(_CubeMaskTex, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _CubeMapIntensity;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_CubeMapBrightness) + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat31) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat31 = max(u_xlat32, _IceCenterTransparency);
    u_xlat31 = min(u_xlat31, 1.0);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _TransparencyExp;
    u_xlat31 = exp2(u_xlat31);
    u_xlat4.w = u_xlat31 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.w = min(max(u_xlat4.w, 0.0), 1.0);
#else
    u_xlat4.w = clamp(u_xlat4.w, 0.0, 1.0);
#endif
    u_xlat5 = vs_TEXCOORD4.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat5 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat5;
    u_xlat5 = u_xlat5 + hlslcc_mtx4x4unity_WorldToLight[3];
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.0<u_xlat5.z);
#else
    u_xlatb31 = 0.0<u_xlat5.z;
#endif
    u_xlat16_6.x = (u_xlatb31) ? 1.0 : 0.0;
    u_xlat8.xy = u_xlat5.xy / u_xlat5.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
    u_xlat31 = texture(_LightTexture0, u_xlat8.xy).w;
    u_xlat16_6.x = u_xlat31 * u_xlat16_6.x;
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = texture(_LightTextureB0, vec2(u_xlat31)).w;
    u_xlat16_6.x = u_xlat31 * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat0.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat13;
vec2 u_xlat23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
float u_xlat33;
lowp float u_xlat10_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat3.xy = u_xlat2.yy * vs_TEXCOORD2.xy;
    u_xlat3.xy = vs_TEXCOORD1.xy * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = vs_TEXCOORD3.xy * u_xlat2.zz + u_xlat3.xy;
    u_xlat23.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat23.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb31 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat23.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_4.xyz = texture(_TillingNormal, u_xlat23.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat4.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Power;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat23.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat32 = _BumpOffsetHeight + -1.0;
    u_xlat3.xy = u_xlat16_5.xy * _MainNormalIntensity.xy + u_xlat3.xy;
    u_xlat3.xy = vec2(u_xlat32) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat23.xy;
    u_xlat7.x = vs_TEXCOORD1.z;
    u_xlat7.y = vs_TEXCOORD2.z;
    u_xlat7.z = vs_TEXCOORD3.z;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat32 = (-u_xlat32) + 1.0;
    u_xlat32 = max(u_xlat32, 9.99999975e-05);
    u_xlat23.x = log2(u_xlat32);
    u_xlat23.x = u_xlat23.x * _EdgePower;
    u_xlat23.x = exp2(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat10_3 = texture(_BumpTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat23.x) + 1.0;
    u_xlat3.x = u_xlat13 * u_xlat3.x;
    u_xlat8.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyw = u_xlat3.xxx * u_xlat8.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat3.xyw) + _EdgeColor.xyz;
    u_xlat3.xyz = u_xlat23.xxx * u_xlat8.xyz + u_xlat3.xyw;
    u_xlat8.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_33 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat3.xyz) + _ElementPatternColor.xyz;
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat8.xyz + u_xlat3.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat4.xyz = u_xlat4.xyz * _NormalIntensity.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat9.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat9.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat33 = dot((-u_xlat2.xyz), u_xlat9.xyz);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat4.xyz = u_xlat9.xyz * (-vec3(u_xlat33)) + (-u_xlat2.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_CubeMap, u_xlat4.xyz).xyz;
    u_xlat10_33 = texture(_CubeMaskTex, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _CubeMapIntensity;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_CubeMapBrightness) + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat31) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat31 = max(u_xlat32, _IceCenterTransparency);
    u_xlat31 = min(u_xlat31, 1.0);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _TransparencyExp;
    u_xlat31 = exp2(u_xlat31);
    u_xlat4.w = u_xlat31 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.w = min(max(u_xlat4.w, 0.0), 1.0);
#else
    u_xlat4.w = clamp(u_xlat4.w, 0.0, 1.0);
#endif
    u_xlat8.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = texture(_LightTextureB0, vec2(u_xlat31)).w;
    u_xlat32 = texture(_LightTexture0, u_xlat8.xyz).w;
    u_xlat31 = u_xlat31 * u_xlat32;
    u_xlat16_5.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
lowp float u_xlat10_30;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat20.x = (-u_xlat20.x) + 1.0;
    u_xlat20.x = max(u_xlat20.x, 9.99999975e-05);
    u_xlat29 = log2(u_xlat20.x);
    u_xlat29 = u_xlat29 * _EdgePower;
    u_xlat29 = exp2(u_xlat29);
    u_xlat29 = u_xlat29 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat29) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat2.xyw = vec3(u_xlat29) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_30 = texture(_ElementMask, u_xlat7.xy).x;
    u_xlat30 = u_xlat10_30 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat2.xyw) + _ElementPatternColor.xyz;
    u_xlat2.xyw = vec3(u_xlat30) * u_xlat7.xyz + u_xlat2.xyw;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat1.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat10_3.x = texture(_CubeMaskTex, u_xlat7.xy).x;
    u_xlat3.x = u_xlat10_3.x * _CubeMapIntensity;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapBrightness) + (-u_xlat2.xyw);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat1.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat28 = max(u_xlat20.x, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat2.w = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD4.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat28 = texture(_LightTexture0, u_xlat3.xy).w;
    u_xlat16_4.xyz = vec3(u_xlat28) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat13;
vec2 u_xlat23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
float u_xlat33;
lowp float u_xlat10_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat3.xy = u_xlat2.yy * vs_TEXCOORD2.xy;
    u_xlat3.xy = vs_TEXCOORD1.xy * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = vs_TEXCOORD3.xy * u_xlat2.zz + u_xlat3.xy;
    u_xlat23.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat23.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb31 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat23.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_4.xyz = texture(_TillingNormal, u_xlat23.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat4.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Power;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat23.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat32 = _BumpOffsetHeight + -1.0;
    u_xlat3.xy = u_xlat16_5.xy * _MainNormalIntensity.xy + u_xlat3.xy;
    u_xlat3.xy = vec2(u_xlat32) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat23.xy;
    u_xlat7.x = vs_TEXCOORD1.z;
    u_xlat7.y = vs_TEXCOORD2.z;
    u_xlat7.z = vs_TEXCOORD3.z;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat32 = (-u_xlat32) + 1.0;
    u_xlat32 = max(u_xlat32, 9.99999975e-05);
    u_xlat23.x = log2(u_xlat32);
    u_xlat23.x = u_xlat23.x * _EdgePower;
    u_xlat23.x = exp2(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat10_3 = texture(_BumpTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat23.x) + 1.0;
    u_xlat3.x = u_xlat13 * u_xlat3.x;
    u_xlat8.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyw = u_xlat3.xxx * u_xlat8.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat3.xyw) + _EdgeColor.xyz;
    u_xlat3.xyz = u_xlat23.xxx * u_xlat8.xyz + u_xlat3.xyw;
    u_xlat8.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_33 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat3.xyz) + _ElementPatternColor.xyz;
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat8.xyz + u_xlat3.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat4.xyz = u_xlat4.xyz * _NormalIntensity.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat9.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat9.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat33 = dot((-u_xlat2.xyz), u_xlat9.xyz);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat4.xyz = u_xlat9.xyz * (-vec3(u_xlat33)) + (-u_xlat2.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_CubeMap, u_xlat4.xyz).xyz;
    u_xlat10_33 = texture(_CubeMaskTex, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _CubeMapIntensity;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_CubeMapBrightness) + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat31) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat31 = max(u_xlat32, _IceCenterTransparency);
    u_xlat31 = min(u_xlat31, 1.0);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _TransparencyExp;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat32 = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat32 = _ZBufferParams.z * u_xlat32 + _ZBufferParams.w;
    u_xlat32 = float(1.0) / u_xlat32;
    u_xlat32 = u_xlat32 + -9.99999996e-12;
    u_xlat33 = u_xlat32 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat32 = u_xlat32 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat33) + 1.0;
    u_xlat32 = u_xlat32 * u_xlat4.x + u_xlat33;
    u_xlat4.w = u_xlat31 * u_xlat32;
    u_xlat8.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = texture(_LightTexture0, vec2(u_xlat31)).w;
    u_xlat16_5.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
lowp float u_xlat10_30;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat20.x = (-u_xlat20.x) + 1.0;
    u_xlat20.x = max(u_xlat20.x, 9.99999975e-05);
    u_xlat29 = log2(u_xlat20.x);
    u_xlat29 = u_xlat29 * _EdgePower;
    u_xlat29 = exp2(u_xlat29);
    u_xlat29 = u_xlat29 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat29) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat2.xyw = vec3(u_xlat29) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_30 = texture(_ElementMask, u_xlat7.xy).x;
    u_xlat30 = u_xlat10_30 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat2.xyw) + _ElementPatternColor.xyz;
    u_xlat2.xyw = vec3(u_xlat30) * u_xlat7.xyz + u_xlat2.xyw;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat1.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat10_3.x = texture(_CubeMaskTex, u_xlat7.xy).x;
    u_xlat3.x = u_xlat10_3.x * _CubeMapIntensity;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapBrightness) + (-u_xlat2.xyw);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat1.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat28 = max(u_xlat20.x, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999996e-12;
    u_xlat11 = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat20.x = (-u_xlat11) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat20.x + u_xlat11;
    u_xlat2.w = u_xlat28 * u_xlat2.x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat13;
vec2 u_xlat23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
float u_xlat33;
lowp float u_xlat10_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat3.xy = u_xlat2.yy * vs_TEXCOORD2.xy;
    u_xlat3.xy = vs_TEXCOORD1.xy * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = vs_TEXCOORD3.xy * u_xlat2.zz + u_xlat3.xy;
    u_xlat23.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat23.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb31 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat23.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_4.xyz = texture(_TillingNormal, u_xlat23.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat4.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Power;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat23.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat32 = _BumpOffsetHeight + -1.0;
    u_xlat3.xy = u_xlat16_5.xy * _MainNormalIntensity.xy + u_xlat3.xy;
    u_xlat3.xy = vec2(u_xlat32) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat23.xy;
    u_xlat7.x = vs_TEXCOORD1.z;
    u_xlat7.y = vs_TEXCOORD2.z;
    u_xlat7.z = vs_TEXCOORD3.z;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat32 = (-u_xlat32) + 1.0;
    u_xlat32 = max(u_xlat32, 9.99999975e-05);
    u_xlat23.x = log2(u_xlat32);
    u_xlat23.x = u_xlat23.x * _EdgePower;
    u_xlat23.x = exp2(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat10_3 = texture(_BumpTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat23.x) + 1.0;
    u_xlat3.x = u_xlat13 * u_xlat3.x;
    u_xlat8.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyw = u_xlat3.xxx * u_xlat8.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat3.xyw) + _EdgeColor.xyz;
    u_xlat3.xyz = u_xlat23.xxx * u_xlat8.xyz + u_xlat3.xyw;
    u_xlat8.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_33 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat3.xyz) + _ElementPatternColor.xyz;
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat8.xyz + u_xlat3.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat4.xyz = u_xlat4.xyz * _NormalIntensity.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat9.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat9.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat33 = dot((-u_xlat2.xyz), u_xlat9.xyz);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat4.xyz = u_xlat9.xyz * (-vec3(u_xlat33)) + (-u_xlat2.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_CubeMap, u_xlat4.xyz).xyz;
    u_xlat10_33 = texture(_CubeMaskTex, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _CubeMapIntensity;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_CubeMapBrightness) + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat31) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat31 = max(u_xlat32, _IceCenterTransparency);
    u_xlat31 = min(u_xlat31, 1.0);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _TransparencyExp;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat32 = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat32 = _ZBufferParams.z * u_xlat32 + _ZBufferParams.w;
    u_xlat32 = float(1.0) / u_xlat32;
    u_xlat32 = u_xlat32 + -9.99999996e-12;
    u_xlat33 = u_xlat32 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat32 = u_xlat32 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat33) + 1.0;
    u_xlat32 = u_xlat32 * u_xlat4.x + u_xlat33;
    u_xlat4.w = u_xlat31 * u_xlat32;
    u_xlat5 = vs_TEXCOORD4.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat5 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat5;
    u_xlat5 = u_xlat5 + hlslcc_mtx4x4unity_WorldToLight[3];
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.0<u_xlat5.z);
#else
    u_xlatb31 = 0.0<u_xlat5.z;
#endif
    u_xlat16_6.x = (u_xlatb31) ? 1.0 : 0.0;
    u_xlat8.xy = u_xlat5.xy / u_xlat5.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
    u_xlat31 = texture(_LightTexture0, u_xlat8.xy).w;
    u_xlat16_6.x = u_xlat31 * u_xlat16_6.x;
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = texture(_LightTextureB0, vec2(u_xlat31)).w;
    u_xlat16_6.x = u_xlat31 * u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat0.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
float u_xlat13;
vec2 u_xlat23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
float u_xlat33;
lowp float u_xlat10_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat3.xy = u_xlat2.yy * vs_TEXCOORD2.xy;
    u_xlat3.xy = vs_TEXCOORD1.xy * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = vs_TEXCOORD3.xy * u_xlat2.zz + u_xlat3.xy;
    u_xlat23.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_4.xyz = texture(_NormalMap, u_xlat23.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb31 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat23.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_4.xyz = texture(_TillingNormal, u_xlat23.xy).xyz;
        u_xlat16_6.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat4.xyz = u_xlat16_5.xyz;
    //ENDIF
    }
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat31 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat31 = max(u_xlat31, 9.99999975e-05);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Power;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat23.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat32 = _BumpOffsetHeight + -1.0;
    u_xlat3.xy = u_xlat16_5.xy * _MainNormalIntensity.xy + u_xlat3.xy;
    u_xlat3.xy = vec2(u_xlat32) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(0.100000001, 0.100000001) + u_xlat23.xy;
    u_xlat7.x = vs_TEXCOORD1.z;
    u_xlat7.y = vs_TEXCOORD2.z;
    u_xlat7.z = vs_TEXCOORD3.z;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat32 = (-u_xlat32) + 1.0;
    u_xlat32 = max(u_xlat32, 9.99999975e-05);
    u_xlat23.x = log2(u_xlat32);
    u_xlat23.x = u_xlat23.x * _EdgePower;
    u_xlat23.x = exp2(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat10_3 = texture(_BumpTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 * _BumpTexIntensity;
    u_xlat13 = (-u_xlat23.x) + 1.0;
    u_xlat3.x = u_xlat13 * u_xlat3.x;
    u_xlat8.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyw = u_xlat3.xxx * u_xlat8.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat3.xyw) + _EdgeColor.xyz;
    u_xlat3.xyz = u_xlat23.xxx * u_xlat8.xyz + u_xlat3.xyw;
    u_xlat8.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_33 = texture(_ElementMask, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _ElementPatternIntensity;
    u_xlat8.xyz = (-u_xlat3.xyz) + _ElementPatternColor.xyz;
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat8.xyz + u_xlat3.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat4.xyz = u_xlat4.xyz * _NormalIntensity.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
    u_xlat9.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
    u_xlat9.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
    u_xlat33 = dot((-u_xlat2.xyz), u_xlat9.xyz);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat4.xyz = u_xlat9.xyz * (-vec3(u_xlat33)) + (-u_xlat2.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_CubeMap, u_xlat4.xyz).xyz;
    u_xlat10_33 = texture(_CubeMaskTex, u_xlat8.xy).x;
    u_xlat33 = u_xlat10_33 * _CubeMapIntensity;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_CubeMapBrightness) + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat3.xyz = vec3(u_xlat31) * _Highlight_Color.xyz + u_xlat3.xyz;
    u_xlat31 = max(u_xlat32, _IceCenterTransparency);
    u_xlat31 = min(u_xlat31, 1.0);
    u_xlat31 = log2(u_xlat31);
    u_xlat31 = u_xlat31 * _TransparencyExp;
    u_xlat31 = exp2(u_xlat31);
    u_xlat31 = u_xlat31 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat32 = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat32 = _ZBufferParams.z * u_xlat32 + _ZBufferParams.w;
    u_xlat32 = float(1.0) / u_xlat32;
    u_xlat32 = u_xlat32 + -9.99999996e-12;
    u_xlat33 = u_xlat32 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat32 = u_xlat32 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat33) + 1.0;
    u_xlat32 = u_xlat32 * u_xlat4.x + u_xlat33;
    u_xlat4.w = u_xlat31 * u_xlat32;
    u_xlat8.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat31 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat31 = texture(_LightTextureB0, vec2(u_xlat31)).w;
    u_xlat32 = texture(_LightTexture0, u_xlat8.xyz).w;
    u_xlat31 = u_xlat31 * u_xlat32;
    u_xlat16_5.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz;
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat11;
vec2 u_xlat20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
float u_xlat30;
lowp float u_xlat10_30;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xy = u_xlat1.yy * vs_TEXCOORD2.xy;
    u_xlat2.xy = vs_TEXCOORD1.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat2.xy = vs_TEXCOORD3.xy * u_xlat1.zz + u_xlat2.xy;
    u_xlat20.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat20.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat20.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_3.xyz = texture(_TillingNormal, u_xlat20.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat3.xyz = u_xlat16_4.xyz;
    //ENDIF
    }
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat28 = max(u_xlat28, 9.99999975e-05);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Power;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat20.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat30 = _BumpOffsetHeight + -1.0;
    u_xlat2.xy = u_xlat16_4.xy * _MainNormalIntensity.xy + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat30);
    u_xlat2.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat20.xy;
    u_xlat6.x = vs_TEXCOORD1.z;
    u_xlat6.y = vs_TEXCOORD2.z;
    u_xlat6.z = vs_TEXCOORD3.z;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat20.x = inversesqrt(u_xlat20.x);
    u_xlat6.xyz = u_xlat20.xxx * u_xlat6.xyz;
    u_xlat20.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat20.x = (-u_xlat20.x) + 1.0;
    u_xlat20.x = max(u_xlat20.x, 9.99999975e-05);
    u_xlat29 = log2(u_xlat20.x);
    u_xlat29 = u_xlat29 * _EdgePower;
    u_xlat29 = exp2(u_xlat29);
    u_xlat29 = u_xlat29 * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat10_2 = texture(_BumpTex, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _BumpTexIntensity;
    u_xlat11 = (-u_xlat29) + 1.0;
    u_xlat2.x = u_xlat11 * u_xlat2.x;
    u_xlat7.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat7.xyz = u_xlat2.xxx * u_xlat7.xyz + _DarkColor.xyz;
    u_xlat8.xyz = (-u_xlat7.xyz) + _EdgeColor.xyz;
    u_xlat2.xyw = vec3(u_xlat29) * u_xlat8.xyz + u_xlat7.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_30 = texture(_ElementMask, u_xlat7.xy).x;
    u_xlat30 = u_xlat10_30 * _ElementPatternIntensity;
    u_xlat7.xyz = (-u_xlat2.xyw) + _ElementPatternColor.xyz;
    u_xlat2.xyw = vec3(u_xlat30) * u_xlat7.xyz + u_xlat2.xyw;
    u_xlat7.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat3.xyz = u_xlat3.xyz * _NormalIntensity.xyz;
    u_xlat8.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
    u_xlat8.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
    u_xlat8.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
    u_xlat3.x = dot((-u_xlat1.xyz), u_xlat8.xyz);
    u_xlat3.x = u_xlat3.x + u_xlat3.x;
    u_xlat1.xyz = u_xlat8.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx;
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat10_3.x = texture(_CubeMaskTex, u_xlat7.xy).x;
    u_xlat3.x = u_xlat10_3.x * _CubeMapIntensity;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapBrightness) + (-u_xlat2.xyw);
    u_xlat1.xyz = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat1.xyz = vec3(u_xlat28) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat28 = max(u_xlat20.x, _IceCenterTransparency);
    u_xlat28 = min(u_xlat28, 1.0);
    u_xlat28 = log2(u_xlat28);
    u_xlat28 = u_xlat28 * _TransparencyExp;
    u_xlat28 = exp2(u_xlat28);
    u_xlat28 = u_xlat28 * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.x = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999996e-12;
    u_xlat11 = u_xlat2.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat20.x = (-u_xlat11) + 1.0;
    u_xlat2.x = u_xlat2.x * u_xlat20.x + u_xlat11;
    u_xlat2.w = u_xlat28 * u_xlat2.x;
    u_xlat3.xy = vs_TEXCOORD4.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat28 = texture(_LightTexture0, u_xlat3.xy).w;
    u_xlat16_4.xyz = vec3(u_xlat28) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.0399999991;
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 " {
Keywords { "POINT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SPOT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "_SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "META" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 185219
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat0.z);
#else
    u_xlatb12 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb12 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD1.w = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat3.y;
    vs_TEXCOORD3.w = u_xlat3.z;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat8;
vec2 u_xlat15;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.yy * vs_TEXCOORD2.xy;
    u_xlat1.xy = vs_TEXCOORD1.xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy * u_xlat0.zz + u_xlat1.xy;
    u_xlat15.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat15.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb21 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb21){
        u_xlat15.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_2.xyz = texture(_TillingNormal, u_xlat15.xy).xyz;
        u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
        u_xlat2.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat2.xyz = u_xlat16_3.xyz;
    //ENDIF
    }
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Power;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat15.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat23 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat16_3.xy * _MainNormalIntensity.xy + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat15.xy;
    u_xlat5.x = vs_TEXCOORD1.z;
    u_xlat5.y = vs_TEXCOORD2.z;
    u_xlat5.z = vs_TEXCOORD3.z;
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat5.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat15.x = (-u_xlat15.x) + 1.0;
    u_xlat15.x = max(u_xlat15.x, 9.99999975e-05);
    u_xlat15.x = log2(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * _EdgePower;
    u_xlat15.x = exp2(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_BumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _BumpTexIntensity;
    u_xlat8 = (-u_xlat15.x) + 1.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat1.xyw) + _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat15.xxx * u_xlat5.xyz + u_xlat1.xyw;
    u_xlat5.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_22 = texture(_ElementMask, u_xlat5.xy).x;
    u_xlat22 = u_xlat10_22 * _ElementPatternIntensity;
    u_xlat5.xyz = (-u_xlat1.xyz) + _ElementPatternColor.xyz;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat2.xyz = u_xlat2.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat22 = dot((-u_xlat0.xyz), u_xlat6.xyz);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat0.xyz = u_xlat6.xyz * (-vec3(u_xlat22)) + (-u_xlat0.xyz);
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat10_22 = texture(_CubeMaskTex, u_xlat5.xy).x;
    u_xlat22 = u_xlat10_22 * _CubeMapIntensity;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat0.xyz = vec3(u_xlat21) * _Highlight_Color.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat21 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_1 : u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat0.z);
#else
    u_xlatb12 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb12 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD1.y = u_xlat2.x;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD1.w = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.w = u_xlat3.y;
    vs_TEXCOORD3.w = u_xlat3.z;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
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
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _TillingNormal_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _BumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	vec4 _MainNormalIntensity;
uniform 	float _BumpTexIntensity;
uniform 	float _EdgePower;
uniform 	float _EdgeWidth;
uniform 	vec4 _EdgeColor;
uniform 	vec4 _ElementPatternColor;
uniform 	vec4 _ElementMask_ST;
uniform 	float _ElementPatternIntensity;
uniform 	vec4 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _CubeMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _GlobalBightness;
uniform 	float _EmissiveIntensity;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _TillingNormal;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _ElementMask;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat8;
vec2 u_xlat15;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
lowp float u_xlat10_22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xy = u_xlat0.yy * vs_TEXCOORD2.xy;
    u_xlat1.xy = vs_TEXCOORD1.xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy * u_xlat0.zz + u_xlat1.xy;
    u_xlat15.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat15.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb21 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb21){
        u_xlat15.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_2.xyz = texture(_TillingNormal, u_xlat15.xy).xyz;
        u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
        u_xlat2.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat2.xyz = u_xlat16_3.xyz;
    //ENDIF
    }
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = max(u_xlat21, 9.99999975e-05);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Power;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = u_xlat21 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat15.xy = vs_TEXCOORD0.xy * _BumpTex_ST.xy + _BumpTex_ST.zw;
    u_xlat23 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat16_3.xy * _MainNormalIntensity.xy + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat15.xy;
    u_xlat5.x = vs_TEXCOORD1.z;
    u_xlat5.y = vs_TEXCOORD2.z;
    u_xlat5.z = vs_TEXCOORD3.z;
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat5.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat15.x = (-u_xlat15.x) + 1.0;
    u_xlat15.x = max(u_xlat15.x, 9.99999975e-05);
    u_xlat15.x = log2(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * _EdgePower;
    u_xlat15.x = exp2(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_BumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _BumpTexIntensity;
    u_xlat8 = (-u_xlat15.x) + 1.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat5.xyz = (-u_xlat1.xyw) + _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat15.xxx * u_xlat5.xyz + u_xlat1.xyw;
    u_xlat5.xy = vs_TEXCOORD0.xy * _ElementMask_ST.xy + _ElementMask_ST.zw;
    u_xlat10_22 = texture(_ElementMask, u_xlat5.xy).x;
    u_xlat22 = u_xlat10_22 * _ElementPatternIntensity;
    u_xlat5.xyz = (-u_xlat1.xyz) + _ElementPatternColor.xyz;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _CubeMaskTex_ST.xy + _CubeMaskTex_ST.zw;
    u_xlat2.xyz = u_xlat2.xyz * _NormalIntensity.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat22 = dot((-u_xlat0.xyz), u_xlat6.xyz);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat0.xyz = u_xlat6.xyz * (-vec3(u_xlat22)) + (-u_xlat0.xyz);
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat10_22 = texture(_CubeMaskTex, u_xlat5.xy).x;
    u_xlat22 = u_xlat10_22 * _CubeMapIntensity;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlobalBightness, _GlobalBightness, _GlobalBightness));
    u_xlat0.xyz = vec3(u_xlat21) * _Highlight_Color.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat21 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat2.xyz;
    u_xlat16_1.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_1 : u_xlat16_0;
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
Keywords { "_SOFTPARTICLES_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}