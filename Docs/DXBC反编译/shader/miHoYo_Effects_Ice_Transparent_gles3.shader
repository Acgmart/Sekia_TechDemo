//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Ice_Transparent" {
Properties {
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_CubeMap ("CubeMap", Cube) = "white" { }
_CubeMapIntensity ("CubeMapIntensity", Range(0, 1)) = 0.007757068
_CubeMapBrightness ("CubeMapBrightness", Float) = 4
_IceMaskTex ("IceMaskTex", 2D) = "white" { }
_Fresnal_Scale ("Fresnal_Scale", Float) = 1
_Fresnal_Power ("Fresnal_Power", Float) = 1
_Highlight_Color ("Highlight_Color", Color) = (0.7334559,0.8970082,0.9779412,0)
_IceBumpTex ("IceBumpTex", 2D) = "white" { }
_BumpOffsetHeight ("BumpOffsetHeight", Float) = 14.89
_BumpTexIntensity ("BumpTexIntensity", Range(0, 1)) = 1
_IceLightColor ("IceLightColor", Color) = (0.5073529,0.9692103,1,0)
_IceDarkColor ("IceDarkColor", Color) = (0.1098039,0.1686275,0.172549,0)
_IceBightness ("IceBightness", Float) = 1
_EmissiveIntensity ("EmissiveIntensity", Range(0, 1)) = 1
_IceCenterTransparency ("IceCenterTransparency", Range(0, 1)) = 0
_TransparencyExp ("TransparencyExp", Float) = 3.18
_IceTransparency ("IceTransparency", Float) = 2
[MHYToggle] _TillingNormalToggle ("TillingNormalToggle", Float) = 1
_NormalMap ("NormalMap", 2D) = "bump" { }
_TillingNormal ("TillingNormal", 2D) = "bump" { }
_NormalIntensity ("NormalIntensity", Vector) = (0.3,0.3,1,0)
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
  GpuProgramID 55134
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTexture, u_xlat9.xy).x;
    u_xlat9.x = _ZBufferParams.z * u_xlat9.x + _ZBufferParams.w;
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat19;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat1.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat1.xyw = u_xlat3.xyz * u_xlat1.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat0.zw;
    vs_TEXCOORD10.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2.w = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.w);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat9.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat0.xyz = u_xlat0.xxx * _Highlight_Color.xyz + u_xlat9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat20;
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
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat6.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.zxy;
    vs_TEXCOORD6.xyz = u_xlat2.yzx;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yzx;
    vs_TEXCOORD7.xyz = u_xlat3.zxy;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx;
    u_xlat4.xyz = u_xlat3.xyz * u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat4.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat3.x;
    u_xlat5.y = u_xlat4.y;
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz;
    u_xlat3.x = u_xlat2.y;
    u_xlat2.z = u_xlat3.y;
    u_xlat3.y = u_xlat4.x;
    u_xlat2.y = u_xlat4.z;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat6.xxx + u_xlat5.xyz;
    vs_TEXCOORD9.xyz = u_xlat2.xyz * u_xlat6.zzz + u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec3 _ES_MainLightColor;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Power;
uniform 	float _Fresnal_Scale;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	mediump float _TillingNormalToggle;
uniform 	vec4 _TillingNormal_ST;
uniform 	mediump vec3 _NormalIntensity;
uniform 	float _CubeMapBrightness;
uniform 	vec4 _IceMaskTex_ST;
uniform 	float _CubeMapIntensity;
uniform 	float _IceBightness;
uniform 	float _EmissiveIntensity;
uniform 	float _IceCenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _IceTransparency;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _TillingNormal;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _IceMaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
vec2 u_xlat19;
float u_xlat27;
float u_xlat28;
lowp float u_xlat10_28;
bool u_xlatb28;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 1.0);
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.w = (-u_xlat27) + 1.0;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat19.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat19.x = inversesqrt(u_xlat19.x);
    u_xlat4.xyz = u_xlat19.xxx * vs_TEXCOORD9.xyz;
    u_xlat19.x = _BumpOffsetHeight + -1.0;
    u_xlat19.xy = u_xlat4.xy * u_xlat19.xx;
    u_xlat1.xy = u_xlat19.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_1.x = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1.x * _BumpTexIntensity;
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(_TillingNormalToggle==1.0);
#else
    u_xlatb28 = _TillingNormalToggle==1.0;
#endif
    if(u_xlatb28){
        u_xlat7.xy = vs_TEXCOORD0.xy * _TillingNormal_ST.xy + _TillingNormal_ST.zw;
        u_xlat10_7.xyz = texture(_TillingNormal, u_xlat7.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_7.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.xyz;
        u_xlat7.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    } else {
        u_xlat7.xyz = u_xlat16_2.xyz;
    //ENDIF
    }
    u_xlat7.xyz = u_xlat7.xyz * _NormalIntensity.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat3.z = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceMaskTex_ST.xy + _IceMaskTex_ST.zw;
    u_xlat28 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat3.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat4.xyz;
    u_xlat10_3.xyz = texture(_CubeMap, u_xlat3.xyz).xyz;
    u_xlat10_28 = texture(_IceMaskTex, u_xlat5.xy).x;
    u_xlat28 = u_xlat10_28 * _CubeMapIntensity;
    u_xlat3.xyz = u_xlat10_3.xyz * vec3(_CubeMapBrightness) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD7.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xw = max(u_xlat0.xw, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat0.x = max(u_xlat0.x, _IceCenterTransparency);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _TransparencyExp;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _IceTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat9.x = texture(_CameraDepthTextureScaled, u_xlat9.xy).x;
    u_xlat9.x = u_xlat9.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat18 = u_xlat9.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat28 = (-u_xlat18) + 1.0;
    u_xlat9.x = u_xlat9.x * u_xlat28 + u_xlat18;
    u_xlat18 = log2(u_xlat0.w);
    u_xlat18 = u_xlat18 * _Fresnal_Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Fresnal_Scale;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_IceBightness, _IceBightness, _IceBightness));
    u_xlat1.xyz = vec3(u_xlat18) * _Highlight_Color.xyz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _ES_MainLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveIntensity, _EmissiveIntensity, _EmissiveIntensity));
    u_xlat1.w = u_xlat9.x * u_xlat0.x;
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
Keywords { "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}