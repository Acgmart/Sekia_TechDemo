//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Dungeon_Ice" {
Properties {
_MaineTex ("MaineTex", 2D) = "white" { }
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_SurfaceColor ("SurfaceColor", Color) = (1,1,1,0)
_Desaturate ("Desaturate", Range(0, 1)) = 0
_Brightness ("Brightness", Range(0, 2)) = 0
_SurfaceIntensity ("SurfaceIntensity", Float) = 1
_NoisePower ("NoisePower", Float) = 1
_MainColor ("MainColor", Color) = (1,1,1,0)
_Fresnel ("Fresnel", Float) = 5
_NormalMap ("NormalMap", 2D) = "bump" { }
_NormalIntensity ("NormalIntensity", Range(0, 1)) = 0
_Noise ("Noise", 2D) = "white" { }
_IceScopeTex ("IceScopeTex", 2D) = "white" { }
_CreviceColor ("CreviceColor", Color) = (1,1,1,0)
_CubeMap ("CubeMap", Cube) = "white" { }
_RefColor ("RefColor", Color) = (1,1,1,0)
_RefIntensity ("RefIntensity", Range(0, 1)) = 0.5
_SurfaceColor02 ("SurfaceColor02", Color) = (1,1,1,0)
_IceScope ("IceScope", Range(0.8, 1)) = 0
_SnowScope ("SnowScope", 2D) = "white" { }
_SnowTex ("SnowTex", 2D) = "white" { }
_SnowColor ("SnowColor", Color) = (1,1,1,0)
_SnowRange ("SnowRange", Range(0, 1)) = 0
_texcoord ("", 2D) = "white" { }
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
  GpuProgramID 8312
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat1.x = vs_TEXCOORD5.x;
    u_xlat1.y = vs_TEXCOORD7.x;
    u_xlat1.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat16_4.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = (-u_xlat15) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _Fresnel;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat15 = dot((-u_xlat0.xyz), u_xlat16_4.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_4.xyz * (-vec3(u_xlat15)) + (-u_xlat0.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_15 = texture(_MaineTex, u_xlat1.xy).x;
    u_xlat16_1.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_15) * u_xlat16_1.xyz + _MainColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_0.x = texture(_Noise, u_xlat0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _NoisePower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SurfaceColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(_SurfaceIntensity) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_0.x = texture(_IceScopeTex, u_xlat0.xy).x;
    u_xlat16_18 = _IceScope + -1.0;
    u_xlat16_0.x = u_xlat10_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _SurfaceColor02.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_5 = texture(_SnowTex, u_xlat5.xy).x;
    u_xlat16_0.x = u_xlat10_5 * u_xlat10_0.x;
    u_xlat16_18 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_18;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_3.xyz);
    u_xlat16_18 = u_xlat16_0.x * _SnowColor.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat5.x * u_xlat10 + u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
    SV_Target0.w = u_xlat0.x;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _Brightness;
uniform 	mediump float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	mediump float _RefIntensity;
uniform 	mediump float _Fresnel;
uniform 	mediump vec4 _RefColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _CreviceColor;
uniform 	vec4 _MaineTex_ST;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoisePower;
uniform 	mediump vec4 _SurfaceColor;
uniform 	mediump float _SurfaceIntensity;
uniform 	mediump vec4 _SurfaceColor02;
uniform 	vec4 _IceScopeTex_ST;
uniform 	mediump float _IceScope;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _SnowColor;
uniform 	vec4 _SnowScope_ST;
uniform 	vec4 _SnowTex_ST;
uniform 	mediump float _SnowRange;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _MaineTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _IceScopeTex;
uniform lowp sampler2D _SnowScope;
uniform lowp sampler2D _SnowTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16_3.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat5.x = vs_TEXCOORD5.z;
    u_xlat5.y = vs_TEXCOORD7.z;
    u_xlat5.z = vs_TEXCOORD6.z;
    u_xlat16_3.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat6.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat16_1.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Fresnel;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat6.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_RefIntensity);
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaineTex_ST.xy + _MaineTex_ST.zw;
    u_xlat10_21 = texture(_MaineTex, u_xlat2.xy).x;
    u_xlat16_2.xyz = (-_MainColor.xyz) + _CreviceColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_21) * u_xlat16_2.xyz + _MainColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat10_21 = texture(_Noise, u_xlat4.xy).x;
    u_xlat16_21 = max(u_xlat10_21, 9.99999975e-05);
    u_xlat16_21 = log2(u_xlat16_21);
    u_xlat16_21 = u_xlat16_21 * _NoisePower;
    u_xlat16_21 = exp2(u_xlat16_21);
    u_xlat16_4.xyz = vec3(u_xlat16_21) * _SurfaceColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _IceScopeTex_ST.xy + _IceScopeTex_ST.zw;
    u_xlat10_21 = texture(_IceScopeTex, u_xlat5.xy).x;
    u_xlat16_1.x = _IceScope + -1.0;
    u_xlat16_21 = u_xlat10_21 * u_xlat16_1.x;
    u_xlat16_21 = u_xlat16_21 * 100.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * _RefColor.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(_SurfaceIntensity) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _SurfaceColor02.xyz * vec3(u_xlat16_21) + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SnowScope_ST.xy + _SnowScope_ST.zw;
    u_xlat14.xy = vs_TEXCOORD0.xy * _SnowTex_ST.xy + _SnowTex_ST.zw;
    u_xlat10_0.x = texture(_SnowScope, u_xlat0.xy).x;
    u_xlat10_7 = texture(_SnowTex, u_xlat14.xy).x;
    u_xlat16_0.x = u_xlat10_7 * u_xlat10_0.x;
    u_xlat16_22 = _SnowRange + -1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_0.x = u_xlat16_0.x * 200.0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_22 = u_xlat16_0.x * _SnowColor.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = _SnowColor.xyz * u_xlat16_0.xxx + (-u_xlat16_1.xyz);
    SV_Target0.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat7 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7;
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