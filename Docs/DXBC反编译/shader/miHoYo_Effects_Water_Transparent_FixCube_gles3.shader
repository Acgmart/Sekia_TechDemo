//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Water_Transparent_FixCube" {
Properties {
_ShallowColor ("ShallowColor", Color) = (0,1,0.5862069,0)
_DeepColor ("DeepColor", Color) = (0,0,0,0)
_ShoreTransparency ("ShoreTransparency", Range(0, 10)) = 0.04
_ShoreFade ("ShoreFade", Range(0, 5)) = 5
_Normal01 ("Normal01", 2D) = "white" { }
_DeepColorDepth ("DeepColorDepth", Range(0, 10)) = 0.04
_DeepColorFade ("DeepColorFade", Range(0, 5)) = 1
_Normal01_U_Speed ("Normal01_U_Speed", Float) = 0
_Normal01_VSpeed ("Normal01_V-Speed", Float) = 0
_Normal02 ("Normal02", 2D) = "bump" { }
_Normal02_U_Speed ("Normal02_U_Speed", Float) = 0
_Normal02_V_Speed ("Normal02_V_Speed", Float) = 0
_NormalMapBias ("NormalMapBias", Float) = -1
_NormalMapScale ("NormalMapScale", Float) = 1
_DistortionIntensity ("DistortionIntensity", Color) = (1,1,1,0)
_Reflection ("Reflection", Cube) = "black" { }
_ReflectionIntensity ("ReflectionIntensity", Range(0, 1)) = 0.6
_FresnelPower ("FresnelPower", Range(0, 5)) = 5
_SSRDistortion ("SSRDistortion", Float) = 2
_SSRIntensity ("SSRIntensity", Range(0, 1)) = 0
_RefractionIntensity ("RefractionIntensity", Float) = 0
_Gloss ("Gloss", Float) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_SpecularPower ("SpecularPower", Range(0, 10)) = 1
_FoamTexture ("FoamTexture", 2D) = "black" { }
_FoamColor ("FoamColor", Color) = (1,1,1,1)
_FoamWidth ("FoamWidth", Range(0, 5)) = 0.5
_FoamFade ("FoamFade", Range(0, 2)) = 2
_FoamSpeed ("FoamSpeed", Float) = 0
_FoamFadeDistance ("FoamFadeDistance", Float) = 2
_FoamFadeOffset ("FoamFadeOffset", Float) = 0
_CausticTex ("CausticTex", 2D) = "white" { }
_CausticIntensity ("CausticIntensity", Float) = 1
_CausticColor ("CausticColor", Color) = (1,1,1,0)
_CausticTiling ("CausticTiling", Range(0, 1)) = 1
_CausticDistortionSpeed ("CausticDistortionSpeed", Range(0.1, 1)) = 1
_CausticDistortionTiling ("CausticDistortionTiling", Range(0, 1)) = 0.03588236
_CausticDistortionValue ("CausticDistortionValue", Range(0, 1)) = 0.1
_CausticFade ("CausticFade", Range(0.01, 10)) = 1
_CausticFadePower ("CausticFadePower", Range(0.1, 10)) = 0.1
_CausticDepth ("CausticDepth", Range(0.01, 50)) = 0.5
_CausticDistance ("CausticDistance", Float) = 2
_CausticOffset ("CausticOffset", Float) = 0
_WaterMeshScale ("WaterMeshScale", Vector) = (1,1,1,0)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "SUBSHADER 0 PASS 0"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 25554
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
float u_xlat27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
float u_xlat27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
float u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15 = float(1.0) / _FoamFade;
    u_xlat15 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat15 = u_xlat41 * _FoamWidth;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat14 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
float u_xlat27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
float u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15 = float(1.0) / _FoamFade;
    u_xlat15 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat15 = u_xlat41 * _FoamWidth;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat14 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
float u_xlat27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec3 u_xlat15;
mediump float u_xlat16_16;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat36 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat37 = u_xlat36 * -1.44269502;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = u_xlat37 / u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.00999999978<abs(u_xlat36));
#else
    u_xlatb36 = 0.00999999978<abs(u_xlat36);
#endif
    u_xlat16_4.x = (u_xlatb36) ? u_xlat37 : 1.0;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = sqrt(u_xlat36);
    u_xlat37 = u_xlat36 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat37 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat37 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(0.00999999978<abs(u_xlat37));
#else
    u_xlatb37 = 0.00999999978<abs(u_xlat37);
#endif
    u_xlat16_16 = (u_xlatb37) ? u_xlat3.x : 1.0;
    u_xlat37 = u_xlat36 * _HeigtFogParams2.y;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat16_16 = exp2((-u_xlat16_16));
    u_xlat16_4.y = (-u_xlat16_16) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat37 = u_xlat36 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat37) + 2.0;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat37 = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat37 = u_xlat37 + 1.0;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat37 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat37) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat6.xyz);
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat13.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat13.x;
#endif
    u_xlat13.x = u_xlat36 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + (-_HeigtFogRamp.w);
    u_xlat36 = u_xlat36 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat25.x = (-u_xlat13.x) + 2.0;
    u_xlat13.x = u_xlat25.x * u_xlat13.x;
    u_xlat25.x = u_xlat13.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat25.x : u_xlat13.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat13.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat13.x) + 2.0;
    u_xlat16_4.x = u_xlat13.x * u_xlat16_4.x;
    u_xlat15.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat15.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat15.xyz = vec3(u_xlat36) * u_xlat6.xyz + u_xlat15.xyz;
    u_xlat15.xyz = u_xlat1.xxx * u_xlat15.xyz;
    u_xlat36 = (-u_xlat1.x) + 1.0;
    u_xlat36 = u_xlat3.x * u_xlat36;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat15.xyz;
    u_xlat3.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat12;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat15.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat15.x;
#endif
    u_xlat12 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat32 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat32 * u_xlat12;
    u_xlat32 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat32 : u_xlat12;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat12 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat12) + 2.0;
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat2.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat2.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec3 u_xlat15;
mediump float u_xlat16_16;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat36 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat37 = u_xlat36 * -1.44269502;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = u_xlat37 / u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.00999999978<abs(u_xlat36));
#else
    u_xlatb36 = 0.00999999978<abs(u_xlat36);
#endif
    u_xlat16_4.x = (u_xlatb36) ? u_xlat37 : 1.0;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = sqrt(u_xlat36);
    u_xlat37 = u_xlat36 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat37 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat37 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(0.00999999978<abs(u_xlat37));
#else
    u_xlatb37 = 0.00999999978<abs(u_xlat37);
#endif
    u_xlat16_16 = (u_xlatb37) ? u_xlat3.x : 1.0;
    u_xlat37 = u_xlat36 * _HeigtFogParams2.y;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat16_16 = exp2((-u_xlat16_16));
    u_xlat16_4.y = (-u_xlat16_16) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat37 = u_xlat36 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat37) + 2.0;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat37 = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat37 = u_xlat37 + 1.0;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat37 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat37) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat6.xyz);
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat13.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat13.x;
#endif
    u_xlat13.x = u_xlat36 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + (-_HeigtFogRamp.w);
    u_xlat36 = u_xlat36 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat25.x = (-u_xlat13.x) + 2.0;
    u_xlat13.x = u_xlat25.x * u_xlat13.x;
    u_xlat25.x = u_xlat13.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat25.x : u_xlat13.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat13.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat13.x) + 2.0;
    u_xlat16_4.x = u_xlat13.x * u_xlat16_4.x;
    u_xlat15.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat15.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat15.xyz = vec3(u_xlat36) * u_xlat6.xyz + u_xlat15.xyz;
    u_xlat15.xyz = u_xlat1.xxx * u_xlat15.xyz;
    u_xlat36 = (-u_xlat1.x) + 1.0;
    u_xlat36 = u_xlat3.x * u_xlat36;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat15.xyz;
    u_xlat3.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec3 u_xlat15;
mediump float u_xlat16_16;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat36 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat37 = u_xlat36 * -1.44269502;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = u_xlat37 / u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.00999999978<abs(u_xlat36));
#else
    u_xlatb36 = 0.00999999978<abs(u_xlat36);
#endif
    u_xlat16_4.x = (u_xlatb36) ? u_xlat37 : 1.0;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = sqrt(u_xlat36);
    u_xlat37 = u_xlat36 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat37 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat37 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(0.00999999978<abs(u_xlat37));
#else
    u_xlatb37 = 0.00999999978<abs(u_xlat37);
#endif
    u_xlat16_16 = (u_xlatb37) ? u_xlat3.x : 1.0;
    u_xlat37 = u_xlat36 * _HeigtFogParams2.y;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat16_16 = exp2((-u_xlat16_16));
    u_xlat16_4.y = (-u_xlat16_16) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat37 = u_xlat36 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat37) + 2.0;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat37 = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat37 = u_xlat37 + 1.0;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat37 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat37) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat6.xyz);
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat13.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat13.x;
#endif
    u_xlat13.x = u_xlat36 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + (-_HeigtFogRamp.w);
    u_xlat36 = u_xlat36 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat25.x = (-u_xlat13.x) + 2.0;
    u_xlat13.x = u_xlat25.x * u_xlat13.x;
    u_xlat25.x = u_xlat13.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat25.x : u_xlat13.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat13.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat13.x) + 2.0;
    u_xlat16_4.x = u_xlat13.x * u_xlat16_4.x;
    u_xlat15.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat15.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat15.xyz = vec3(u_xlat36) * u_xlat6.xyz + u_xlat15.xyz;
    u_xlat15.xyz = u_xlat1.xxx * u_xlat15.xyz;
    u_xlat36 = (-u_xlat1.x) + 1.0;
    u_xlat36 = u_xlat3.x * u_xlat36;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat15.xyz;
    u_xlat3.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat12;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat15.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat15.x;
#endif
    u_xlat12 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat32 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat32 * u_xlat12;
    u_xlat32 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat32 : u_xlat12;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat12 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat12) + 2.0;
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat2.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat2.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec3 u_xlat15;
mediump float u_xlat16_16;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat36 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat37 = u_xlat36 * -1.44269502;
    u_xlat37 = exp2(u_xlat37);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = u_xlat37 / u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.00999999978<abs(u_xlat36));
#else
    u_xlatb36 = 0.00999999978<abs(u_xlat36);
#endif
    u_xlat16_4.x = (u_xlatb36) ? u_xlat37 : 1.0;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = sqrt(u_xlat36);
    u_xlat37 = u_xlat36 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat37 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat37 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(0.00999999978<abs(u_xlat37));
#else
    u_xlatb37 = 0.00999999978<abs(u_xlat37);
#endif
    u_xlat16_16 = (u_xlatb37) ? u_xlat3.x : 1.0;
    u_xlat37 = u_xlat36 * _HeigtFogParams2.y;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat16_16 = exp2((-u_xlat16_16));
    u_xlat16_4.y = (-u_xlat16_16) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat37 = u_xlat36 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat37) + 2.0;
    u_xlat16_16 = u_xlat37 * u_xlat16_16;
    u_xlat37 = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat37 = u_xlat37 + 1.0;
    u_xlat16_4.x = u_xlat37 * u_xlat16_4.x;
    u_xlat37 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat37) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat6.xyz);
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat13.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat13.x;
#endif
    u_xlat13.x = u_xlat36 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + (-_HeigtFogRamp.w);
    u_xlat36 = u_xlat36 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat25.x = (-u_xlat13.x) + 2.0;
    u_xlat13.x = u_xlat25.x * u_xlat13.x;
    u_xlat25.x = u_xlat13.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat25.x : u_xlat13.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat13.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat13.x) + 2.0;
    u_xlat16_4.x = u_xlat13.x * u_xlat16_4.x;
    u_xlat15.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat15.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat15.xyz = vec3(u_xlat36) * u_xlat6.xyz + u_xlat15.xyz;
    u_xlat15.xyz = u_xlat1.xxx * u_xlat15.xyz;
    u_xlat36 = (-u_xlat1.x) + 1.0;
    u_xlat36 = u_xlat3.x * u_xlat36;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat15.xyz;
    u_xlat3.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
mediump float u_xlat16_16;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
bool u_xlatb40;
float u_xlat41;
bool u_xlatb41;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat41 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat41) + 2.0;
    u_xlat41 = u_xlat41 * u_xlat5.x;
    u_xlat5.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!((-u_xlat40)>=u_xlat5.x);
#else
    u_xlatb40 = (-u_xlat40)>=u_xlat5.x;
#endif
    u_xlat5.x = u_xlat41 * _HeigtFogColDelta.w;
    u_xlat40 = (u_xlatb40) ? u_xlat5.x : u_xlat41;
    u_xlat40 = log2(u_xlat40);
    u_xlat40 = u_xlat40 * unity_FogColor.w;
    u_xlat40 = exp2(u_xlat40);
    u_xlat40 = min(u_xlat40, _HeigtFogColBase.w);
    u_xlat41 = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat41) + 2.0;
    u_xlat16_3.x = u_xlat41 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat41 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat41 = u_xlat41 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat41 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(0.00999999978<abs(u_xlat41));
#else
    u_xlatb44 = 0.00999999978<abs(u_xlat41);
#endif
    u_xlat6.x = u_xlat41 * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat41 = u_xlat6.x / u_xlat41;
    u_xlat16_3.x = (u_xlatb44) ? u_xlat41 : 1.0;
    u_xlat15.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.00999999978<abs(u_xlat15.x));
#else
    u_xlatb41 = 0.00999999978<abs(u_xlat15.x);
#endif
    u_xlat44 = u_xlat15.x * -1.44269502;
    u_xlat44 = exp2(u_xlat44);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat15.x = u_xlat44 / u_xlat15.x;
    u_xlat16_3.y = (u_xlatb41) ? u_xlat15.x : 1.0;
    u_xlat15.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_3.xy = u_xlat15.yx * u_xlat16_3.xy;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_16 = exp2((-u_xlat16_3.y));
    u_xlat16_3.y = (-u_xlat16_16) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat2.x) + 2.0;
    u_xlat16_16 = u_xlat2.x * u_xlat16_16;
    u_xlat2.x = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3.x = u_xlat2.x * u_xlat16_3.x;
    u_xlat2.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat15.xyz = u_xlat15.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz;
    u_xlat44 = (-u_xlat2.x) + 1.0;
    u_xlat5.xyz = vec3(u_xlat44) * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx + u_xlat5.xyz;
    u_xlat40 = (-u_xlat40) + 1.0;
    u_xlat40 = u_xlat44 * u_xlat40;
    u_xlat1.xyz = vec3(u_xlat40) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat12;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat15.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat15.x;
#endif
    u_xlat12 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat32 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat32 * u_xlat12;
    u_xlat32 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat32 : u_xlat12;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat12 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat12) + 2.0;
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat2.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat2.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
mediump float u_xlat16_16;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
bool u_xlatb40;
float u_xlat41;
bool u_xlatb41;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat41 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat41) + 2.0;
    u_xlat41 = u_xlat41 * u_xlat5.x;
    u_xlat5.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!((-u_xlat40)>=u_xlat5.x);
#else
    u_xlatb40 = (-u_xlat40)>=u_xlat5.x;
#endif
    u_xlat5.x = u_xlat41 * _HeigtFogColDelta.w;
    u_xlat40 = (u_xlatb40) ? u_xlat5.x : u_xlat41;
    u_xlat40 = log2(u_xlat40);
    u_xlat40 = u_xlat40 * unity_FogColor.w;
    u_xlat40 = exp2(u_xlat40);
    u_xlat40 = min(u_xlat40, _HeigtFogColBase.w);
    u_xlat41 = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat41) + 2.0;
    u_xlat16_3.x = u_xlat41 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat41 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat41 = u_xlat41 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat41 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(0.00999999978<abs(u_xlat41));
#else
    u_xlatb44 = 0.00999999978<abs(u_xlat41);
#endif
    u_xlat6.x = u_xlat41 * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat41 = u_xlat6.x / u_xlat41;
    u_xlat16_3.x = (u_xlatb44) ? u_xlat41 : 1.0;
    u_xlat15.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.00999999978<abs(u_xlat15.x));
#else
    u_xlatb41 = 0.00999999978<abs(u_xlat15.x);
#endif
    u_xlat44 = u_xlat15.x * -1.44269502;
    u_xlat44 = exp2(u_xlat44);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat15.x = u_xlat44 / u_xlat15.x;
    u_xlat16_3.y = (u_xlatb41) ? u_xlat15.x : 1.0;
    u_xlat15.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_3.xy = u_xlat15.yx * u_xlat16_3.xy;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_16 = exp2((-u_xlat16_3.y));
    u_xlat16_3.y = (-u_xlat16_16) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat2.x) + 2.0;
    u_xlat16_16 = u_xlat2.x * u_xlat16_16;
    u_xlat2.x = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3.x = u_xlat2.x * u_xlat16_3.x;
    u_xlat2.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat15.xyz = u_xlat15.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz;
    u_xlat44 = (-u_xlat2.x) + 1.0;
    u_xlat5.xyz = vec3(u_xlat44) * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx + u_xlat5.xyz;
    u_xlat40 = (-u_xlat40) + 1.0;
    u_xlat40 = u_xlat44 * u_xlat40;
    u_xlat1.xyz = vec3(u_xlat40) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
mediump float u_xlat16_16;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
bool u_xlatb40;
float u_xlat41;
bool u_xlatb41;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat41 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat41) + 2.0;
    u_xlat41 = u_xlat41 * u_xlat5.x;
    u_xlat5.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!((-u_xlat40)>=u_xlat5.x);
#else
    u_xlatb40 = (-u_xlat40)>=u_xlat5.x;
#endif
    u_xlat5.x = u_xlat41 * _HeigtFogColDelta.w;
    u_xlat40 = (u_xlatb40) ? u_xlat5.x : u_xlat41;
    u_xlat40 = log2(u_xlat40);
    u_xlat40 = u_xlat40 * unity_FogColor.w;
    u_xlat40 = exp2(u_xlat40);
    u_xlat40 = min(u_xlat40, _HeigtFogColBase.w);
    u_xlat41 = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat41) + 2.0;
    u_xlat16_3.x = u_xlat41 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat41 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat41 = u_xlat41 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat41 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(0.00999999978<abs(u_xlat41));
#else
    u_xlatb44 = 0.00999999978<abs(u_xlat41);
#endif
    u_xlat6.x = u_xlat41 * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat41 = u_xlat6.x / u_xlat41;
    u_xlat16_3.x = (u_xlatb44) ? u_xlat41 : 1.0;
    u_xlat15.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.00999999978<abs(u_xlat15.x));
#else
    u_xlatb41 = 0.00999999978<abs(u_xlat15.x);
#endif
    u_xlat44 = u_xlat15.x * -1.44269502;
    u_xlat44 = exp2(u_xlat44);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat15.x = u_xlat44 / u_xlat15.x;
    u_xlat16_3.y = (u_xlatb41) ? u_xlat15.x : 1.0;
    u_xlat15.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_3.xy = u_xlat15.yx * u_xlat16_3.xy;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_16 = exp2((-u_xlat16_3.y));
    u_xlat16_3.y = (-u_xlat16_16) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat2.x) + 2.0;
    u_xlat16_16 = u_xlat2.x * u_xlat16_16;
    u_xlat2.x = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3.x = u_xlat2.x * u_xlat16_3.x;
    u_xlat2.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat15.xyz = u_xlat15.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz;
    u_xlat44 = (-u_xlat2.x) + 1.0;
    u_xlat5.xyz = vec3(u_xlat44) * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx + u_xlat5.xyz;
    u_xlat40 = (-u_xlat40) + 1.0;
    u_xlat40 = u_xlat44 * u_xlat40;
    u_xlat1.xyz = vec3(u_xlat40) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat12;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat15.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat15.x;
#endif
    u_xlat12 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat32 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat32 * u_xlat12;
    u_xlat32 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat32 : u_xlat12;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat12 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat12) + 2.0;
    u_xlat16_4.x = u_xlat12 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat2.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat2.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
mediump float u_xlat16_16;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
bool u_xlatb40;
float u_xlat41;
bool u_xlatb41;
float u_xlat44;
bool u_xlatb44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat15.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat41 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat41) + 2.0;
    u_xlat41 = u_xlat41 * u_xlat5.x;
    u_xlat5.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!((-u_xlat40)>=u_xlat5.x);
#else
    u_xlatb40 = (-u_xlat40)>=u_xlat5.x;
#endif
    u_xlat5.x = u_xlat41 * _HeigtFogColDelta.w;
    u_xlat40 = (u_xlatb40) ? u_xlat5.x : u_xlat41;
    u_xlat40 = log2(u_xlat40);
    u_xlat40 = u_xlat40 * unity_FogColor.w;
    u_xlat40 = exp2(u_xlat40);
    u_xlat40 = min(u_xlat40, _HeigtFogColBase.w);
    u_xlat41 = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat41) + 2.0;
    u_xlat16_3.x = u_xlat41 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat41 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat41 = u_xlat41 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat41 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(0.00999999978<abs(u_xlat41));
#else
    u_xlatb44 = 0.00999999978<abs(u_xlat41);
#endif
    u_xlat6.x = u_xlat41 * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat41 = u_xlat6.x / u_xlat41;
    u_xlat16_3.x = (u_xlatb44) ? u_xlat41 : 1.0;
    u_xlat15.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb41 = !!(0.00999999978<abs(u_xlat15.x));
#else
    u_xlatb41 = 0.00999999978<abs(u_xlat15.x);
#endif
    u_xlat44 = u_xlat15.x * -1.44269502;
    u_xlat44 = exp2(u_xlat44);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat15.x = u_xlat44 / u_xlat15.x;
    u_xlat16_3.y = (u_xlatb41) ? u_xlat15.x : 1.0;
    u_xlat15.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_3.xy = u_xlat15.yx * u_xlat16_3.xy;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_16 = exp2((-u_xlat16_3.y));
    u_xlat16_3.y = (-u_xlat16_16) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat2.x) + 2.0;
    u_xlat16_16 = u_xlat2.x * u_xlat16_16;
    u_xlat2.x = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_3.x = u_xlat2.x * u_xlat16_3.x;
    u_xlat2.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15.x = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat15.xyz = u_xlat15.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz;
    u_xlat44 = (-u_xlat2.x) + 1.0;
    u_xlat5.xyz = vec3(u_xlat44) * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx + u_xlat5.xyz;
    u_xlat40 = (-u_xlat40) + 1.0;
    u_xlat40 = u_xlat44 * u_xlat40;
    u_xlat1.xyz = vec3(u_xlat40) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
}
}
 Pass {
  Name "FORWARDSHADERLOD"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" "ShaderLod" = "true" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 94830
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
float u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15 = float(1.0) / _FoamFade;
    u_xlat15 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat15 = u_xlat41 * _FoamWidth;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat14 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
float u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15 = float(1.0) / _FoamFade;
    u_xlat15 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat15 = u_xlat41 * _FoamWidth;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat14 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
float u_xlat8;
float u_xlat24;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat7.w = u_xlat1.x * 0.5;
    u_xlat7.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat7.zz + u_xlat7.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat8 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat8;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec4 u_xlat8;
vec3 u_xlat9;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat3.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    u_xlat3.xyw = u_xlat2.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.w = 1.0;
    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat4.xyz = u_xlat9.xxx * u_xlat4.xyz;
    u_xlat16_5.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_5.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_5.x);
    u_xlat16_6 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_6);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_6);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_6);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    u_xlat9.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat8.w = u_xlat9.x * 0.5;
    u_xlat8.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat2.z;
    u_xlat3.xy = u_xlat8.zz + u_xlat8.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat9.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat9.x;
    u_xlat9.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat9.x;
    vs_TEXCOORD3.z = (-u_xlat9.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat9.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat9.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat9.xyz;
    vs_TEXCOORD7.xyz = u_xlat9.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat9.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat9.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat9.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    u_xlat0.xyz = vs_TEXCOORD0.www * u_xlat0.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat3.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat3.xyw = u_xlat1.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat1.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat15.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat15.x;
#endif
    u_xlat11 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat31 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat31 * u_xlat11;
    u_xlat31 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat31 : u_xlat11;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat1.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat1.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTexture, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.xy = _ZBufferParams.zx * vec2(u_xlat37) + _ZBufferParams.wy;
    u_xlat24.xy = vec2(1.0, 1.0) / u_xlat24.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.yyy;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyw = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat24.xxx * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat24.x = texture(_CameraDepthTexture, u_xlat25.xy).x;
    u_xlat24.x = _ZBufferParams.z * u_xlat24.x + _ZBufferParams.w;
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat24.x = u_xlat24.x + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = u_xlat24.xx * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.xxx;
    u_xlat0.xyw = u_xlat13.xxx * u_xlat0.xyw;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat24.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyw + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyw * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat24.x * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat24.x * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyw = (-u_xlat3.xyz) * u_xlat0.xyw + u_xlat6.xyz;
    u_xlat0.xyw = u_xlat25.xxx * u_xlat0.xyw + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat24.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyw;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat24.x = u_xlat24.x * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat24.x = min(max(u_xlat24.x, 0.0), 1.0);
#else
    u_xlat24.x = clamp(u_xlat24.x, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat24.x = u_xlat24.x * u_xlat16_13;
    u_xlat24.x = u_xlat1.x * u_xlat24.x;
    u_xlat0.xyz = u_xlat24.xxx * _FoamColor.xyz + u_xlat0.xyw;
    u_xlat0.xyz = vs_TEXCOORD0.www * u_xlat0.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.www * u_xlat0.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat3.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat3.xyw = u_xlat1.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat1.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat15.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat15.x;
#endif
    u_xlat11 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat31 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat31 * u_xlat11;
    u_xlat31 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat31 : u_xlat11;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat1.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat1.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
float u_xlat12;
mediump float u_xlat16_12;
vec2 u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
bool u_xlatb13;
vec2 u_xlat24;
mediump vec2 u_xlat16_24;
lowp vec2 u_xlat10_24;
vec2 u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
float u_xlat36;
float u_xlat37;
float u_xlat39;
void main()
{
    u_xlat0.x = _CausticDistortionTiling * 200.0;
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD3.xy;
    u_xlat24.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _CausticDistortionSpeed;
    u_xlat24.xy = u_xlat24.xy * vec2(1.5, 1.5) + (-u_xlat1.xx);
    u_xlat0.xy = _WaterMeshScale.xz * u_xlat0.xy + u_xlat1.xx;
    u_xlat10_0.xy = texture(_CausticTex, u_xlat0.xy).yz;
    u_xlat10_24.xy = texture(_CausticTex, u_xlat24.xy).yz;
    u_xlat16_24.xy = (-u_xlat10_0.xy) + u_xlat10_24.xy;
    u_xlat16_0.xy = u_xlat16_24.xy * vec2(0.600000024, 0.600000024) + u_xlat10_0.xy;
    u_xlat0.xy = u_xlat16_0.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat24.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat1.xyz = u_xlat24.xxx * vs_TEXCOORD7.xyz;
    u_xlat24.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat37 = texture(_CameraDepthTextureScaled, u_xlat24.xy).x;
    u_xlat10_2 = texture(_CameraNormalsTexture, u_xlat24.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat24.x = _ZBufferParams.x * u_xlat37 + _ZBufferParams.y;
    u_xlat36 = u_xlat37 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat24.x = float(1.0) / u_xlat24.x;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat24.xxx;
    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat0.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat1.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CausticTex, u_xlat0.xy).x;
    u_xlat16_12 = dot(u_xlat16_2, u_xlat16_2);
    u_xlat16_12 = inversesqrt(u_xlat16_12);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz;
    u_xlat12 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _CausticColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_CausticIntensity);
    u_xlat0.xyz = u_xlat10_0.xxx * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat1.y;
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _WaterMeshScale.xz;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat2.y;
    u_xlat10_2.xyz = texture(_Normal01, u_xlat3.xy, _NormalMapBias).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_2.wwz;
    u_xlat16_5.xy = u_xlat16_2.xy * vec2(_NormalMapScale);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_5.z = -1.0;
    u_xlat16_4.xyz = u_xlat16_4.xzy + u_xlat16_5.xzy;
    u_xlat1.xy = u_xlat16_4.xz * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat25.x = float(1.0) / vs_TEXCOORD5.w;
    u_xlat25.x = u_xlat25.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat25.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD5.ww;
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat3.xyz = u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat3.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz + vs_TEXCOORD5.xyw;
    u_xlat25.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD5.ww;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat1.xy).xyz;
    u_xlat36 = texture(_CameraDepthTextureScaled, u_xlat25.xy).x;
    u_xlat36 = u_xlat36 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat1.xy = vec2(u_xlat36) * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat13.x = (-u_xlat1.y) + 1.0;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _CausticFadePower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat13.xxx * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat13.x = u_xlat1.x + (-_CausticOffset);
    u_xlat1.x = u_xlat1.x + (-_FoamFadeOffset);
    u_xlat1.x = u_xlat1.x / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _FoamWidth;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat36 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.y = u_xlat13.x / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.y = min(max(u_xlat1.y, 0.0), 1.0);
#else
    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
#endif
    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy + u_xlat10_3.xyz;
    u_xlat13.x = float(1.0) / _ShoreTransparency;
    u_xlat25.x = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat25.x = min(max(u_xlat25.x, 0.0), 1.0);
#else
    u_xlat25.x = clamp(u_xlat25.x, 0.0, 1.0);
#endif
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _ShoreFade;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat3.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + _DeepColor.xyz;
    u_xlat7.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat37 = 0.100000001 / _DeepColorDepth;
    u_xlat37 = u_xlat36 * u_xlat37;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat37 = u_xlat37 * _DeepColorFade;
    u_xlat37 = exp2(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat7.xyz;
    u_xlat37 = u_xlat36 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat37 = min(max(u_xlat37, 0.0), 1.0);
#else
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat16_4.xzy * _DistortionIntensity.xyz;
    u_xlat9.xy = u_xlat8.xy * vec2(_SSRDistortion);
    u_xlat9.xy = u_xlat9.xy * vec2(u_xlat37) + vs_TEXCOORD5.xy;
    u_xlat9.xy = u_xlat9.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_SSRTexture, u_xlat9.xy).wxyz;
    u_xlat9.x = vs_TEXCOORD8.x;
    u_xlat9.y = vs_TEXCOORD9.x;
    u_xlat9.z = vs_TEXCOORD6.x;
    u_xlat9.x = dot(u_xlat9.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.y;
    u_xlat10.y = vs_TEXCOORD9.y;
    u_xlat10.z = vs_TEXCOORD6.y;
    u_xlat9.y = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat10.x = vs_TEXCOORD8.z;
    u_xlat10.y = vs_TEXCOORD9.z;
    u_xlat10.z = vs_TEXCOORD6.z;
    u_xlat9.z = dot(u_xlat10.xyz, u_xlat8.xyz);
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat9.xyz;
    u_xlat9.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat39 = inversesqrt(u_xlat37);
    u_xlat37 = sqrt(u_xlat37);
    u_xlat37 = u_xlat37 * 0.00499999989;
    u_xlat37 = min(u_xlat37, 1.0);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat10.xyz = vec3(u_xlat39) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat39) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat39 = dot((-u_xlat10.xyz), u_xlat8.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat8.xyz = u_xlat8.xyz * (-vec3(u_xlat39)) + (-u_xlat10.xyz);
    u_xlat10_8.xyz = texture(_Reflection, u_xlat8.xyz).xyz;
    u_xlat16_11.xyz = vec3(u_xlat10_2.y + (-u_xlat10_8.x), u_xlat10_2.z + (-u_xlat10_8.y), u_xlat10_2.w + (-u_xlat10_8.z));
    u_xlat16_2.x = u_xlat10_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat37 = u_xlat37 * u_xlat16_2.x;
    u_xlat11.xyz = u_xlat16_11.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat8.xyz = vec3(u_xlat37) * u_xlat11.xyz + u_xlat10_8.xyz;
    u_xlat8.xyz = (-u_xlat6.xyz) + u_xlat8.xyz;
    u_xlat37 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat11.xyz = vec3(u_xlat37) * vs_TEXCOORD6.xyz;
    u_xlat37 = dot(u_xlat10.xyz, u_xlat11.xyz);
    u_xlat37 = (-u_xlat37) + 1.0;
    u_xlat37 = max(u_xlat37, 9.99999975e-05);
    u_xlat37 = log2(u_xlat37);
    u_xlat39 = u_xlat37 * _FresnelPower;
    u_xlat37 = u_xlat37 * _SpecularPower;
    u_xlat37 = exp2(u_xlat37);
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = u_xlat39 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat39) * u_xlat8.xyz + u_xlat6.xyz;
    u_xlat0.xyz = (-u_xlat3.xyz) * u_xlat0.xyz + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat25.xxx * u_xlat0.xyz + u_xlat7.xyz;
    u_xlat25.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat25.x = inversesqrt(u_xlat25.x);
    u_xlat3.xyz = u_xlat25.xxx * u_xlat9.xyz;
    u_xlat16_4.y = 1.0;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat25.x = dot(u_xlat16_6.xyz, u_xlat3.xyz);
    u_xlat25.x = max(u_xlat25.x, 9.99999975e-05);
    u_xlat25.x = log2(u_xlat25.x);
    u_xlat3.x = _Gloss * 128.0;
    u_xlat25.x = u_xlat25.x * u_xlat3.x;
    u_xlat25.x = exp2(u_xlat25.x);
    u_xlat25.x = u_xlat25.x * _SpecularIntensity;
    u_xlat25.x = max(u_xlat25.x, 0.0);
    u_xlat25.x = min(u_xlat25.x, 16.0);
    u_xlat3.xyz = u_xlat25.xxx * _LightColor0.xyz;
    u_xlat25.x = u_xlat36 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat25.x;
    u_xlat13.x = u_xlat13.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat13.xxx * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb13 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat37) + u_xlat0.xyz;
    u_xlat13.x = float(1.0) / _FoamFade;
    u_xlat36 = u_xlat36 * u_xlat13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat13.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat3.xy = u_xlat13.xy * _WaterMeshScale.xx;
    u_xlat37 = _Time.y * _FoamSpeed;
    u_xlat2 = vec4(u_xlat37) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat3.xy = u_xlat3.xy * vec2(0.600000024, 0.600000024) + u_xlat2.zw;
    u_xlat13.xy = _WaterMeshScale.xx * u_xlat13.xy + u_xlat2.xy;
    u_xlat10_13 = texture(_FoamTexture, u_xlat13.xy).x;
    u_xlat10_25 = texture(_FoamTexture, u_xlat3.xy).x;
    u_xlat16_25 = u_xlat10_25 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_25 * u_xlat10_13;
    u_xlat36 = u_xlat36 * u_xlat16_13;
    u_xlat36 = u_xlat1.x * u_xlat36;
    u_xlat0.xyz = vec3(u_xlat36) * _FoamColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.www * u_xlat0.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
float u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15 = float(1.0) / _FoamFade;
    u_xlat15 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat15 = u_xlat41 * _FoamWidth;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat14 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat1.xyz = vs_TEXCOORD0.www * u_xlat1.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat3.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat3.xyw = u_xlat1.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat1.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat15.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat15.x;
#endif
    u_xlat11 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat31 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat31 * u_xlat11;
    u_xlat31 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat31 : u_xlat11;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat1.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat1.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
float u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
vec2 u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat28.xy = _ZBufferParams.zx * u_xlat28.xx + _ZBufferParams.wy;
    u_xlat28.xy = vec2(1.0, 1.0) / u_xlat28.xy;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28.x + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat32.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD5.w);
    u_xlat28.x = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat28.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat28.yyy;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = u_xlat28.xxxx * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15 = float(1.0) / _FoamFade;
    u_xlat15 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat15 = u_xlat41 * _FoamWidth;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat14 = u_xlat14 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat1.xyz = vs_TEXCOORD0.www * u_xlat1.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat12;
float u_xlat13;
mediump float u_xlat16_14;
float u_xlat21;
float u_xlat27;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat2.xyw = u_xlat1.xyw;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyw;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyw;
    u_xlat3.xyz = u_xlat1.xyw + (-_WorldSpaceCameraPos.xyz);
    u_xlat30 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat4 = u_xlat30 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_5.x = (u_xlatb30) ? u_xlat4 : 1.0;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat4 = u_xlat30 * _HeigtFogParams.y;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat4 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat13 = u_xlat4 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_14 = (u_xlatb4) ? u_xlat13 : 1.0;
    u_xlat4 = u_xlat30 * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_5.y = (-u_xlat16_14) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat4 = u_xlat30 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat4) + 2.0;
    u_xlat16_14 = u_xlat4 * u_xlat16_14;
    u_xlat4 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat4 = u_xlat4 + 1.0;
    u_xlat16_5.x = u_xlat4 * u_xlat16_5.x;
    u_xlat4 = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat4) + 1.0;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat12.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat12.x;
#endif
    u_xlat12.x = u_xlat30 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat30 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat30 = (-u_xlat12.x) + 2.0;
    u_xlat12.x = u_xlat30 * u_xlat12.x;
    u_xlat30 = u_xlat12.x * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat30 : u_xlat12.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat12.x = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat12.x) + 2.0;
    u_xlat16_5.x = u_xlat12.x * u_xlat16_5.x;
    u_xlat6.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat21) * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat12.xyz = u_xlat3.xxx * u_xlat12.xyz;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat13 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat12.xyz;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyw;
    u_xlat1.xyw = vec3(u_xlat30) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyw * vec3(u_xlat4) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_5.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_5.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_5.x);
    u_xlat16_4 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat1.x * 0.5;
    u_xlat6.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat2;
    vs_TEXCOORD5.xyw = u_xlat2.xyw;
    u_xlat9 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat9;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat1.xyz = vs_TEXCOORD0.www * u_xlat1.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_14;
vec3 u_xlat15;
float u_xlat20;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat3.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    u_xlat3.xyw = u_xlat1.xyw;
    gl_Position = u_xlat3;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyw = u_xlat10.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10.x = u_xlat1.y * _HeigtFogParams.x;
    u_xlat30 = u_xlat10.x * -1.44269502;
    u_xlat30 = exp2(u_xlat30);
    u_xlat30 = (-u_xlat30) + 1.0;
    u_xlat30 = u_xlat30 / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4.x = (u_xlatb10) ? u_xlat30 : 1.0;
    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat30 = u_xlat10.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat30 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat30 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat16_14 = (u_xlatb30) ? u_xlat5.x : 1.0;
    u_xlat30 = u_xlat10.x * _HeigtFogParams2.y;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat16_14 = exp2((-u_xlat16_14));
    u_xlat16_4.y = (-u_xlat16_14) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat30 = u_xlat10.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat30) + 2.0;
    u_xlat16_14 = u_xlat30 * u_xlat16_14;
    u_xlat30 = u_xlat16_14 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat30 = u_xlat30 + 1.0;
    u_xlat16_4.x = u_xlat30 * u_xlat16_4.x;
    u_xlat30 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat30) + 1.0;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyw, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat15.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat15.x;
#endif
    u_xlat11 = u_xlat10.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat31 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat31 * u_xlat11;
    u_xlat31 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat31 : u_xlat11;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat10.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat20 = u_xlat10.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat15.xyz = vec3(u_xlat20) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat6.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat10.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz;
    u_xlat10.x = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat10.x;
    u_xlat1.xyw = u_xlat5.xxx * u_xlat6.xyz;
    vs_TEXCOORD0.xyz = u_xlat15.xyz * vec3(u_xlat30) + u_xlat1.xyw;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat5.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat5.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat5.xyz;
    u_xlat16_8.x = u_xlat4.y * u_xlat4.y;
    u_xlat16_8.x = u_xlat4.x * u_xlat4.x + (-u_xlat16_8.x);
    u_xlat16_5 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_8.xyz = unity_SHC.xyz * u_xlat16_8.xxx + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_8.xyz;
    u_xlat10.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat10.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.z = u_xlat1.z;
    u_xlat3.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD2 = u_xlat3;
    vs_TEXCOORD5.xyw = u_xlat3.xyw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    u_xlat10.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat10.x;
    u_xlat10.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat10.x;
    vs_TEXCOORD3.z = (-u_xlat10.x);
    vs_TEXCOORD4.w = 0.0;
    u_xlat10.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat10.xyz;
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yyy;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xxx + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].zzz + u_xlat10.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].www + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat10.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat10.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www + u_xlat1.xyz;
    u_xlat10.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat10.xyz;
    vs_TEXCOORD7.xyz = u_xlat10.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD7.w = 0.0;
    u_xlat10.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat10.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat10.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat4.zxy;
    u_xlat0.xyz = u_xlat4.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat30 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _SpecularIntensity;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _NormalMapScale;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	vec3 _WaterMeshScale;
uniform 	float _Normal01_VSpeed;
uniform 	mediump float _NormalMapBias;
uniform 	float _Normal02_U_Speed;
uniform 	vec4 _Normal02_ST;
uniform 	float _Normal02_V_Speed;
uniform 	float _Gloss;
uniform 	float _RefractionIntensity;
uniform 	float _ShoreTransparency;
uniform 	float _SpecularPower;
uniform 	vec4 _ShallowColor;
uniform 	float _ShoreFade;
uniform 	vec4 _CausticColor;
uniform 	float _CausticIntensity;
uniform 	float _CausticTiling;
uniform 	float _CausticDistortionValue;
uniform 	float _CausticDistortionTiling;
uniform 	float _CausticDistortionSpeed;
uniform 	float _CausticFade;
uniform 	float _CausticFadePower;
uniform 	float _CausticDepth;
uniform 	float _CausticDistance;
uniform 	float _CausticOffset;
uniform 	vec4 _DeepColor;
uniform 	float _DeepColorDepth;
uniform 	float _DeepColorFade;
uniform 	vec4 _DistortionIntensity;
uniform 	float _SSRDistortion;
uniform 	float _SSRIntensity;
uniform 	float _ReflectionIntensity;
uniform 	float _FresnelPower;
uniform 	vec4 _FoamTexture_ST;
uniform 	float _FoamSpeed;
uniform 	float _FoamFade;
uniform 	float _FoamWidth;
uniform 	float _FoamFadeDistance;
uniform 	float _FoamFadeOffset;
uniform 	vec4 _FoamColor;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _Normal01;
uniform lowp sampler2D _Normal02;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _CausticTex;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _SSRTexture;
uniform lowp sampler2D _FoamTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec4 u_xlat6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_9;
lowp vec2 u_xlat10_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
vec3 u_xlat12;
float u_xlat14;
vec3 u_xlat15;
float u_xlat27;
mediump float u_xlat16_27;
lowp float u_xlat10_27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
lowp float u_xlat10_28;
vec2 u_xlat32;
vec2 u_xlat35;
mediump vec2 u_xlat16_35;
lowp vec2 u_xlat10_35;
float u_xlat40;
float u_xlat41;
float u_xlat44;
float u_xlat45;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD3.xy * _Normal02_ST.xy + _Normal02_ST.zw;
    u_xlat0.xy = u_xlat0.xy * _WaterMeshScale.xz;
    u_xlat2.x = _Time.y * _Normal02_U_Speed + u_xlat0.x;
    u_xlat2.y = _Time.y * _Normal02_V_Speed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy, _NormalMapBias).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_0.xy * vec2(_NormalMapScale);
    u_xlat10_1.xyz = texture(_Normal02, u_xlat2.xy, _NormalMapBias).xyz;
    u_xlat16_0.w = -1.0;
    u_xlat16_4.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_0.wwz;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_NormalMapScale);
    u_xlat16_3.z = -1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xz = u_xlat16_3.xy;
    u_xlat16_4.y = 1.0;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat41) + vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat2.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat16_1.xyz, u_xlat2.xyz);
    u_xlat14 = _Gloss * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0>=_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0>=_ES_SunDirection.xxyz.z;
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * u_xlat14;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SpecularIntensity;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 16.0);
    u_xlat14 = float(1.0) / vs_TEXCOORD5.w;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat28 = texture(_CameraDepthTextureScaled, u_xlat2.xy).x;
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_RefractionIntensity, _RefractionIntensity));
    u_xlat14 = u_xlat14 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD5.ww;
    u_xlat14 = u_xlat28 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat14) * u_xlat6.xy;
    u_xlat6.z = 0.0;
    u_xlat7.xyz = u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat7.xy = u_xlat7.xy / u_xlat7.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat14) * u_xlat6.xyz + vs_TEXCOORD5.xyw;
    u_xlat32.xy = u_xlat6.xy / u_xlat6.zz;
    u_xlat14 = texture(_CameraDepthTextureScaled, u_xlat32.xy).x;
    u_xlat14 = u_xlat14 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat41 = float(1.0) / _ShoreTransparency;
    u_xlat44 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat44 = inversesqrt(u_xlat44);
    u_xlat7.xyz = vec3(u_xlat44) * vs_TEXCOORD6.xyz;
    u_xlat44 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat44 = (-u_xlat44) + 1.0;
    u_xlat44 = max(u_xlat44, 9.99999975e-05);
    u_xlat44 = log2(u_xlat44);
    u_xlat32.x = u_xlat44 * _SpecularPower;
    u_xlat32.x = exp2(u_xlat32.x);
    u_xlat7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat1.x = u_xlat14 + -1.0;
    u_xlat1.x = u_xlat41 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    u_xlat7.xyz = (bool(u_xlatb27)) ? vec3(0.0, 0.0, 0.0) : u_xlat7.xyz;
    u_xlat1.x = u_xlat14 * u_xlat41;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _ShoreFade;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat8.xyz = _ShallowColor.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat2.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_27 = dot(u_xlat16_0, u_xlat16_0);
    u_xlat16_27 = inversesqrt(u_xlat16_27);
    u_xlat16_2.xyw = u_xlat16_0.xyz * vec3(u_xlat16_27);
    u_xlat27 = dot(vec3(_ES_SunDirection.x, _ES_SunDirection.y, _ES_SunDirection.z), u_xlat16_2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.x = _ZBufferParams.x * u_xlat28 + _ZBufferParams.y;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat15.x = _ProjectionParams.z / vs_TEXCOORD7.z;
    u_xlat15.xyz = u_xlat15.xxx * vs_TEXCOORD7.xyz;
    u_xlat2.xyz = u_xlat15.xyz * u_xlat2.xxx;
    u_xlat9.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xzw;
    u_xlat2.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xzw * u_xlat2.xxx + u_xlat9.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xzw * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xzw;
    u_xlat41 = _CausticDistortionTiling * 200.0;
    u_xlat9.xy = vec2(u_xlat41) * vs_TEXCOORD3.xy;
    u_xlat35.xy = u_xlat9.xy * _WaterMeshScale.xz;
    u_xlat41 = _Time.y * _CausticDistortionSpeed;
    u_xlat9.xy = _WaterMeshScale.xz * u_xlat9.xy + vec2(u_xlat41);
    u_xlat10_9.xy = texture(_CausticTex, u_xlat9.xy).yz;
    u_xlat35.xy = u_xlat35.xy * vec2(1.5, 1.5) + (-vec2(u_xlat41));
    u_xlat10_35.xy = texture(_CausticTex, u_xlat35.xy).yz;
    u_xlat16_35.xy = (-u_xlat10_9.xy) + u_xlat10_35.xy;
    u_xlat16_9.xy = u_xlat16_35.xy * vec2(0.600000024, 0.600000024) + u_xlat10_9.xy;
    u_xlat41 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat45 = u_xlat41 + (-_CausticOffset);
    u_xlat45 = u_xlat45 / _CausticDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat45 = min(max(u_xlat45, 0.0), 1.0);
#else
    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
#endif
    u_xlat10.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat10.xyz = u_xlat10.xyz * _CausticColor.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(_CausticIntensity);
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat9.xy = u_xlat16_9.xy * vec2(vec2(_CausticDistortionValue, _CausticDistortionValue));
    u_xlat2.xy = vec2(vec2(_CausticTiling, _CausticTiling)) * u_xlat2.xy + u_xlat9.xy;
    u_xlat10_27 = texture(_CausticTex, u_xlat2.xy).x;
    u_xlat2.xyz = vec3(u_xlat10_27) * u_xlat10.xyz;
    u_xlat9.xy = vec2(float(1.0) / float(_CausticFade), float(1.0) / float(_CausticDepth));
    u_xlat9.xy = vec2(u_xlat14) * u_xlat9.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xy = min(max(u_xlat9.xy, 0.0), 1.0);
#else
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat9.x, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _CausticFadePower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat9.y) + 1.0;
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat27 = (-u_xlat45) + 1.0;
    u_xlat6.xy = u_xlat6.xy / vs_TEXCOORD5.ww;
    u_xlat10_6.xyw = texture(_SceneScaledBufferBeforTransParent, u_xlat6.xy).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat10_6.xyw;
    u_xlat6.xyw = u_xlat2.xyz * u_xlat8.xyz;
    u_xlat27 = 0.100000001 / _DeepColorDepth;
    u_xlat27 = u_xlat27 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _DeepColorFade;
    u_xlat27 = exp2(u_xlat27);
    u_xlat9.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + _DeepColor.xyz;
    u_xlat9.xyz = vec3(u_xlat27) * u_xlat9.xyz + u_xlat6.xyw;
    u_xlat10.xyz = u_xlat16_3.xyz * _DistortionIntensity.xyz;
    u_xlat11.x = vs_TEXCOORD8.x;
    u_xlat11.y = vs_TEXCOORD9.x;
    u_xlat11.z = vs_TEXCOORD6.x;
    u_xlat11.x = dot(u_xlat11.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.y;
    u_xlat12.y = vs_TEXCOORD9.y;
    u_xlat12.z = vs_TEXCOORD6.y;
    u_xlat11.y = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat12.x = vs_TEXCOORD8.z;
    u_xlat12.y = vs_TEXCOORD9.z;
    u_xlat12.z = vs_TEXCOORD6.z;
    u_xlat11.z = dot(u_xlat12.xyz, u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat11.xyz;
    u_xlat27 = dot((-u_xlat5.xyz), u_xlat11.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat5.xyz = u_xlat11.xyz * (-vec3(u_xlat27)) + (-u_xlat5.xyz);
    u_xlat10_5.xyz = texture(_Reflection, u_xlat5.xyz).xyz;
    u_xlat10.xy = u_xlat10.xy * vec2(_SSRDistortion);
    u_xlat27 = u_xlat14 * 0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10.xy = u_xlat10.xy * vec2(u_xlat27) + vs_TEXCOORD5.xy;
    u_xlat10.xy = u_xlat10.xy / vs_TEXCOORD5.ww;
    u_xlat10_0 = texture(_SSRTexture, u_xlat10.xy).wxyz;
    u_xlat16_10.xyz = vec3((-u_xlat10_5.x) + u_xlat10_0.y, (-u_xlat10_5.y) + u_xlat10_0.z, (-u_xlat10_5.z) + u_xlat10_0.w);
    u_xlat10.xyz = u_xlat16_10.xyz * vec3(vec3(_SSRIntensity, _SSRIntensity, _SSRIntensity));
    u_xlat16_0.x = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat27 = sqrt(u_xlat40);
    u_xlat27 = u_xlat27 * 0.00499999989;
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat16_0.x * u_xlat27;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat10.xyz + u_xlat10_5.xyz;
    u_xlat27 = u_xlat44 * _FresnelPower;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _ReflectionIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat9.xyz) + u_xlat5.xyz;
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat8.xyz) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz + u_xlat6.xyw;
    u_xlat2.xy = vs_TEXCOORD3.xy * _FoamTexture_ST.xy + _FoamTexture_ST.zw;
    u_xlat28 = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat2.xy * _WaterMeshScale.xx;
    u_xlat0 = vec4(u_xlat28) * vec4(0.0599999987, 0.0399999991, -0.0480000004, 0.027999999);
    u_xlat2.xy = _WaterMeshScale.xx * u_xlat2.xy + u_xlat0.xy;
    u_xlat5.xy = u_xlat5.xy * vec2(0.600000024, 0.600000024) + u_xlat0.zw;
    u_xlat10_28 = texture(_FoamTexture, u_xlat5.xy).x;
    u_xlat16_28 = u_xlat10_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat41 = u_xlat41 + (-_FoamFadeOffset);
    u_xlat41 = u_xlat41 / _FoamFadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat41 = min(max(u_xlat41, 0.0), 1.0);
#else
    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
#endif
    u_xlat1.xzw = u_xlat7.xyz * u_xlat32.xxx + u_xlat1.xzw;
    u_xlat10_2 = texture(_FoamTexture, u_xlat2.xy).x;
    u_xlat16_2.x = u_xlat16_28 * u_xlat10_2;
    u_xlat15.x = float(1.0) / _FoamFade;
    u_xlat15.x = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat15.x * u_xlat16_2.x;
    u_xlat15.x = u_xlat41 * _FoamWidth;
    u_xlat15.x = float(1.0) / u_xlat15.x;
    u_xlat14 = u_xlat14 * u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat2.x;
    u_xlat1.xyz = vec3(u_xlat14) * _FoamColor.xyz + u_xlat1.xzw;
    u_xlat1.xyz = vs_TEXCOORD0.www * u_xlat1.xyz + vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}