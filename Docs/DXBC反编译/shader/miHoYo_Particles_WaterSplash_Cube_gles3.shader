//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/WaterSplash_Cube" {
Properties {
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_NormalMap ("NormalMap", 2D) = "white" { }
_Reflection ("Reflection", Cube) = "black" { }
_ReflectionBrightness ("ReflectionBrightness", Float) = 1
_DistortionIntensity ("DistortionIntensity", Color) = (1,1,1,0)
_AlphaScaler ("Alpha Scaler", Range(0, 50)) = 1
_ReflectionIntensity ("ReflectionIntensity", Range(0, 1)) = 1
_SpalshTex ("SpalshTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _SplashTexChannelSwitch ("SplashTexChannelSwitch", Float) = 0
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
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
  GpuProgramID 40141
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat5.x * u_xlat9 + u_xlat1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat5.x * u_xlat9 + u_xlat1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat15;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat16_1);
    u_xlat0.x = u_xlat15 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat15 = _ZBufferParams.z * u_xlat15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat0.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat15 = _ZBufferParams.z * u_xlat15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat0.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat2;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat15;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0 = (u_xlatb3.z) ? u_xlat2.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat2.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat2.x : u_xlat0;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat0 = u_xlat0 * u_xlat1.w;
    u_xlat0 = u_xlat0 * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0 * _DayColor.w;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat0 = u_xlat0 + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat5.x = u_xlat1.w * u_xlat3.x;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat2.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat0 = u_xlat0 + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat5.x = u_xlat1.w * u_xlat3.x;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat2.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat2;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat15;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat16_1);
    u_xlat0.x = u_xlat15 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat15 = u_xlat15 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat0.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat15 = u_xlat15 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat0.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat2;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat15;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0 = (u_xlatb3.z) ? u_xlat2.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat2.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat2.x : u_xlat0;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat0 = u_xlat0 * u_xlat1.w;
    u_xlat0 = u_xlat0 * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0 * _DayColor.w;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat5.x = u_xlat1.w * u_xlat3.x;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat2.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat5.x = u_xlat1.w * u_xlat3.x;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat2.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat2;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat5.x * u_xlat9 + u_xlat1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
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
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat20 = u_xlat19 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat20 = u_xlat20 / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat20 : 1.0;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat20 = u_xlat19 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat20 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat20 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_9 = (u_xlatb20) ? u_xlat4.x : 1.0;
    u_xlat20 = u_xlat19 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat20 = u_xlat19 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat20 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat20) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat8);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat8;
#endif
    u_xlat8 = u_xlat19 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat19 = u_xlat19 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat8 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat8) + 2.0;
    u_xlat16_3.x = u_xlat8 * u_xlat16_3.x;
    u_xlat10.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat10.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat19) * u_xlat5.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat19 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat4.x * u_xlat19;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat10.xyz;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.xyz = vec3(u_xlat19) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    vs_TEXCOORD8.xyz = vec3(u_xlat19) * u_xlat1.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat5.x * u_xlat9 + u_xlat1.x;
    u_xlat5.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
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
bool u_xlatb2;
vec3 u_xlat3;
bool u_xlatb3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
float u_xlat26;
float u_xlat27;
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
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2.xzw = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = u_xlat2.z * _HeigtFogParams.x;
    u_xlat11 = u_xlat3.x * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_4.x = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat11 = u_xlat3.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat11 = u_xlat2.z * _HeigtFogParams2.x;
    u_xlat19 = u_xlat11 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_12 = (u_xlatb11) ? u_xlat19 : 1.0;
    u_xlat11 = u_xlat3.x * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat11 = u_xlat3.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat11) + 2.0;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat11 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat11 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat11) + 1.0;
    u_xlat27 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xzw, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat27);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat27;
#endif
    u_xlat18 = u_xlat3.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat3.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat3.x = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat3.x : u_xlat18;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat18 = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat2.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat18) + 2.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat26) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat10.xyz;
    vs_TEXCOORD3.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat8.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
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
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat20 = u_xlat19 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat20 = u_xlat20 / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat20 : 1.0;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat20 = u_xlat19 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat20 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat20 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_9 = (u_xlatb20) ? u_xlat4.x : 1.0;
    u_xlat20 = u_xlat19 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat20 = u_xlat19 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat20 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat20) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat8);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat8;
#endif
    u_xlat8 = u_xlat19 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat19 = u_xlat19 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat8 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat8) + 2.0;
    u_xlat16_3.x = u_xlat8 * u_xlat16_3.x;
    u_xlat10.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat10.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat19) * u_xlat5.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat19 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat4.x * u_xlat19;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat10.xyz;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.xyz = vec3(u_xlat19) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    vs_TEXCOORD8.xyz = vec3(u_xlat19) * u_xlat1.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
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
bool u_xlatb2;
vec3 u_xlat3;
bool u_xlatb3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
float u_xlat26;
float u_xlat27;
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
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2.xzw = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = u_xlat2.z * _HeigtFogParams.x;
    u_xlat11 = u_xlat3.x * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_4.x = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat11 = u_xlat3.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat11 = u_xlat2.z * _HeigtFogParams2.x;
    u_xlat19 = u_xlat11 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_12 = (u_xlatb11) ? u_xlat19 : 1.0;
    u_xlat11 = u_xlat3.x * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat11 = u_xlat3.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat11) + 2.0;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat11 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat11 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat11) + 1.0;
    u_xlat27 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xzw, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat27);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat27;
#endif
    u_xlat18 = u_xlat3.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat3.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat3.x = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat3.x : u_xlat18;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat18 = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat2.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat18) + 2.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat26) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat10.xyz;
    vs_TEXCOORD3.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat8.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
int u_xlati12;
float u_xlat13;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat15;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat16_1);
    u_xlat0.x = u_xlat15 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat15 = _ZBufferParams.z * u_xlat15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat0.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
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
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat20 = u_xlat19 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat20 = u_xlat20 / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat20 : 1.0;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat20 = u_xlat19 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat20 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat20 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_9 = (u_xlatb20) ? u_xlat4.x : 1.0;
    u_xlat20 = u_xlat19 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat20 = u_xlat19 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat20 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat20) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat8);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat8;
#endif
    u_xlat8 = u_xlat19 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat19 = u_xlat19 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat8 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat8) + 2.0;
    u_xlat16_3.x = u_xlat8 * u_xlat16_3.x;
    u_xlat10.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat10.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat19) * u_xlat5.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat19 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat4.x * u_xlat19;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat10.xyz;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.xyz = vec3(u_xlat19) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    vs_TEXCOORD8.xyz = vec3(u_xlat19) * u_xlat1.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat15 = _ZBufferParams.z * u_xlat15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat15;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0 = (u_xlatb3.z) ? u_xlat2.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat2.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat2.x : u_xlat0;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat0 = u_xlat0 * u_xlat1.w;
    u_xlat0 = u_xlat0 * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0 * _DayColor.w;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat0 = u_xlat0 + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat5.x = u_xlat1.w * u_xlat3.x;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat2.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
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
bool u_xlatb2;
vec3 u_xlat3;
bool u_xlatb3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
float u_xlat26;
float u_xlat27;
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
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2.xzw = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = u_xlat2.z * _HeigtFogParams.x;
    u_xlat11 = u_xlat3.x * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_4.x = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat11 = u_xlat3.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat11 = u_xlat2.z * _HeigtFogParams2.x;
    u_xlat19 = u_xlat11 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_12 = (u_xlatb11) ? u_xlat19 : 1.0;
    u_xlat11 = u_xlat3.x * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat11 = u_xlat3.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat11) + 2.0;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat11 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat11 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat11) + 1.0;
    u_xlat27 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xzw, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat27);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat27;
#endif
    u_xlat18 = u_xlat3.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat3.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat3.x = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat3.x : u_xlat18;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat18 = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat2.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat18) + 2.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat26) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat10.xyz;
    vs_TEXCOORD3.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat8.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat0 = _ZBufferParams.z * u_xlat0 + _ZBufferParams.w;
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat0 = u_xlat0 + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat1.x = u_xlat1.w * u_xlat3.x;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat5.xyz + vs_TEXCOORD3.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat15;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat16_1);
    u_xlat0.x = u_xlat15 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat15 = u_xlat15 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat0.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
float u_xlat20;
bool u_xlatb20;
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
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat20 = u_xlat19 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat20 = u_xlat20 / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat20 : 1.0;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat20 = u_xlat19 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat20 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat20 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_9 = (u_xlatb20) ? u_xlat4.x : 1.0;
    u_xlat20 = u_xlat19 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat20 = u_xlat19 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat20 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat20) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat8);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat8;
#endif
    u_xlat8 = u_xlat19 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat19 = u_xlat19 + (-_HeigtFogRamp.w);
    u_xlat19 = u_xlat19 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat8 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat8) + 2.0;
    u_xlat16_3.x = u_xlat8 * u_xlat16_3.x;
    u_xlat10.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat10.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat19) * u_xlat5.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat19 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat4.x * u_xlat19;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat10.xyz;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.xyz = vec3(u_xlat19) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat4.zxy;
    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    vs_TEXCOORD8.xyz = vec3(u_xlat19) * u_xlat1.xyz;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
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
    u_xlat10 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * vs_TEXCOORD8.xyz;
    u_xlat10_0.xyz = texture(_NormalMap, u_xlat0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat15 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat15 = u_xlat15 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat1.x = u_xlat15 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat15 * u_xlat6 + u_xlat1.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat1 = texture(_SpalshTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat11 = (u_xlatb2.z) ? u_xlat1.z : u_xlat16;
    u_xlat6 = (u_xlatb2.y) ? u_xlat1.y : u_xlat11;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat6;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _ES_MainLightColor.xyz;
    u_xlat16_6 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_6);
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat15;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0 = (u_xlatb3.z) ? u_xlat2.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat2.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat2.x : u_xlat0;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat0 = u_xlat0 * u_xlat1.w;
    u_xlat0 = u_xlat0 * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0 * _DayColor.w;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat5.x = u_xlat1.w * u_xlat3.x;
    u_xlat5.x = u_xlat5.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat5.x * u_xlat0;
    u_xlat2.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD3;
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
bool u_xlatb2;
vec3 u_xlat3;
bool u_xlatb3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
float u_xlat26;
float u_xlat27;
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
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2.xzw = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = u_xlat2.z * _HeigtFogParams.x;
    u_xlat11 = u_xlat3.x * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_4.x = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3.x = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat11 = u_xlat3.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat11 = u_xlat2.z * _HeigtFogParams2.x;
    u_xlat19 = u_xlat11 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_12 = (u_xlatb11) ? u_xlat19 : 1.0;
    u_xlat11 = u_xlat3.x * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat11 = u_xlat3.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat11) + 2.0;
    u_xlat16_12 = u_xlat11 * u_xlat16_12;
    u_xlat11 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat11 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat19 = (-u_xlat11) + 1.0;
    u_xlat27 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xzw, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat27);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat27;
#endif
    u_xlat18 = u_xlat3.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat3.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat3.x = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat3.x : u_xlat18;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat18 = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat2.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat18) + 2.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat26) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat19 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat10.xyz;
    vs_TEXCOORD3.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat2.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat8.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ReflectionBrightness;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _DayColor;
uniform 	vec3 _ES_MainLightColor;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _SplashTexChannelSwitch;
uniform 	vec4 _SpalshTex_ST;
uniform 	float _AlphaScaler;
struct miHoYoParticlesWaterSplash_CubeArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesWaterSplash_Cube {
	miHoYoParticlesWaterSplash_CubeArray_Type miHoYoParticlesWaterSplash_CubeArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _Reflection;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _SpalshTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat8;
float u_xlat13;
float u_xlat15;
float u_xlat18;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat15 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD8.xyz;
    u_xlat10_5.xyz = texture(_NormalMap, u_xlat5.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat5.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat3.xyz * (-u_xlat5.xxx) + (-u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_ReflectionBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = vec3(_ReflectionIntensity) * u_xlat5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1 = vs_COLOR0 * miHoYoParticlesWaterSplash_CubeArray[u_xlati0]._MeshParticleColorArray;
    u_xlat3.xy = vs_TEXCOORD9.xy / vs_TEXCOORD9.ww;
    u_xlat0 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat0 = u_xlat0 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat3.x = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat3.x) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _SpalshTex_ST.xy + _SpalshTex_ST.zw;
    u_xlat2 = texture(_SpalshTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_SplashTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat18 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat18;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat3.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _ES_MainLightColor.xyz;
    u_xlat16_1 = max(_LightColor0.w, 1.0);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat16_1);
    u_xlat1.x = u_xlat1.w * u_xlat3.x;
    u_xlat1.x = u_xlat1.x * _AlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat5.xyz + vs_TEXCOORD3.xyz;
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
Keywords { "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}