//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Waterfall_Multi_Foam" {
Properties {
[Header(Main Settings)] [MHYToggle] _ApplyEnvironmet ("Apply Environmet", Float) = 1
_BumpMap ("Mask (RG Normal, B Foam, A Falls Foam)", 2D) = "bump" { }
_NormalScale ("Normal Scale", Range(0, 2)) = 0.5
_ShadowBump ("Shadow Bump", Range(0, 2)) = 0.6
_ShadowIntensity ("Shadow Intensity", Range(0, 1)) = 1
_FoamSoften ("Foam Soften", Range(0, 1)) = 0
_FoamRoughnes ("Foam Roughnes", Range(0.01, 0.99)) = 0.5
_RefCube ("Reflection Cube", Cube) = "sky" { }
_MainColor ("Main Color", Color) = (0.7,0.7,0.7,1)
_Speed ("Speed", Range(0, 10)) = 0.5
[Header(Gradient (Transparency with Vertex Color R Channel))] _RefForegroundColor ("Reflection Foreground Color", Color) = (1,1,1,1)
_RefBackgroundColor ("Reflection Background Color", Color) = (1,1,1,1)
[Space] _GradualColor ("Gradual Color", Color) = (1,1,1,1)
_ColorLerpRangeStart ("Gradual Color Start", Range(0, 1)) = 0
_ColorLerpRangeEnd ("Gradual Color End", Range(0, 1)) = 0.5
[Header(Falls Foam (Transparency with Vertex Color G Channel))] _FallFoamColor ("Falls Foam Color", Color) = (1,1,1,1)
_FallFoamClip ("Falls Foam Clip", Range(0, 2)) = 0.5
_FallsFoamSpeed ("Falls Foam Speed", Range(0, 10)) = 0.5
_FallsFoamUScale ("Falls Foam Noise U Scale", Range(-10, 10)) = 1
_FallsFoamVScale ("Falls Foam Noise V Scale", Range(-10, 10)) = 1
[Header(Depth Foam)] _DepthFoamColor ("Depth Foam Color", Color) = (1,1,1,1)
_DepthFoamExtent ("Depth Foam Extent", Range(0.001, 10)) = 1
_DepthFoamAtten ("Depth Foam Atten", Range(0, 10)) = 1
_DepthFoamClip ("Depth Foam Clip", Range(0, 2)) = 0.5
[Header(Bend Foam)] _BendFoamColor ("Bend Foam Color", Color) = (1,1,1,1)
_BendFoamClip ("Bend Foam Clip", Range(0, 2)) = 0.5
_BendFoamWidth ("Bend Foam Width", Range(0, 2)) = 1
_BendFoamOffset ("Bend Foam Offset", Range(-0.5, 0.5)) = 0
[Header(Splash Foam (Clip with Vertex Color B Channel))] _SplashFoamColor ("Splash Foam Color", Color) = (1,1,1,1)
_SplashFoamClip ("Splash Foam Clip", Range(0, 2)) = 0.5
[Header(Bottom Foam (Clip with Vertex Color A Channel))] _BottomFoamColor ("Bottom Foam Color", Color) = (1,1,1,1)
_BottomFoamClip ("Bottom Foam Clip", Range(0, 2)) = 0.5
_BottomFoamClip2 ("Bottom Foam Clip2", Range(0, 2)) = 0.5
_BottomFoamSpeed ("Bottom Foam Speed", Range(0, 10)) = 0.5
_BottomFoamUScale ("Bottom Foam Noise U Scale", Range(-10, 10)) = 1
_BottomFoamVScale ("Bottom Foam Noise V Scale", Range(-10, 10)) = 1
[Header(Alpha)] _AlphaRange ("Alpha Range", Range(0, 10)) = 1
_AlphaIntensity ("Alpha Intensity", Range(0, 10)) = 3
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 Tags { "AllowHalfResolution" = "False" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "AllowHalfResolution" = "False" "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 14126
Program "vp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat10;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat18;
vec2 u_xlat21;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat26 = u_xlat25 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.00999999978<abs(u_xlat25));
#else
    u_xlatb25 = 0.00999999978<abs(u_xlat25);
#endif
    u_xlat16_3.x = (u_xlatb25) ? u_xlat26 : 1.0;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat26 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat26 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_11 = (u_xlatb26) ? u_xlat4.x : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_3.y = (-u_xlat16_11) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat26 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat26) + 2.0;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat26 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat26 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat26) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10;
#endif
    u_xlat10 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat18 * u_xlat10;
    u_xlat18 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat18 : u_xlat10;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat10) + 2.0;
    u_xlat16_3.x = u_xlat10 * u_xlat16_3.x;
    u_xlat12.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat12.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat12.xyz;
    u_xlat12.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat25 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat25;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat25) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21.x = sqrt(u_xlat25);
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21.y = sqrt(u_xlat25);
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat7.xyz);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD3.y = u_xlat7.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat5.z;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat1.y;
    vs_TEXCOORD5.w = u_xlat1.z;
    vs_TEXCOORD4.y = u_xlat7.y;
    vs_TEXCOORD5.y = u_xlat7.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FallsFoamSpeed;
uniform 	mediump float _FallsFoamUScale;
uniform 	mediump float _FallsFoamVScale;
uniform 	mediump float _BottomFoamSpeed;
uniform 	mediump float _BottomFoamUScale;
uniform 	mediump float _BottomFoamVScale;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec4 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
float u_xlat14;
bool u_xlatb14;
vec3 u_xlat15;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_22;
mediump float u_xlat16_26;
float u_xlat28;
mediump float u_xlat16_28;
vec2 u_xlat29;
bool u_xlatb32;
float u_xlat35;
bool u_xlatb35;
mediump float u_xlat16_40;
float u_xlat42;
mediump float u_xlat16_42;
bool u_xlatb42;
float u_xlat43;
bool u_xlatb43;
mediump float u_xlat16_45;
float u_xlat46;
mediump float u_xlat16_46;
int u_xlati46;
uint u_xlatu46;
bool u_xlatb46;
float u_xlat47;
mediump float u_xlat16_47;
bool u_xlatb47;
float u_xlat48;
bool u_xlatb48;
mediump float u_xlat16_50;
mediump float u_xlat16_54;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0.xyz = texture(_BumpMap, u_xlat0.xy).xyz;
    u_xlat42 = _Time.y * _FallsFoamSpeed;
    u_xlat1.y = fract(u_xlat42);
    u_xlat1.x = float(0.0);
    u_xlat29.x = float(0.0);
    u_xlat1.xy = vec2(_FallsFoamUScale, _FallsFoamVScale) * vs_TEXCOORD2.zw + u_xlat1.xy;
    u_xlat42 = _Time.y * _BottomFoamSpeed;
    u_xlat29.y = fract(u_xlat42);
    u_xlat29.xy = vec2(_BottomFoamUScale, _BottomFoamVScale) * vs_TEXCOORD2.zw + u_xlat29.xy;
    u_xlat42 = texture(_BumpMap, u_xlat29.xy).z;
    u_xlat1.x = texture(_BumpMap, u_xlat1.xy).w;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_0 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_0);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat4.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat4.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD3.w;
    u_xlat5.y = vs_TEXCOORD4.w;
    u_xlat5.z = vs_TEXCOORD5.w;
    u_xlat15.xyz = (-u_xlat5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat15.xyz, u_xlat15.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat15.xyz = u_xlat0.xxx * u_xlat15.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat16_3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat4.xyz;
    u_xlat16_45 = dot((-u_xlat7.xyz), u_xlat16_3.xyz);
    u_xlat16_45 = u_xlat16_45 + u_xlat16_45;
    u_xlat16_8.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_45)) + (-u_xlat7.xyz);
    u_xlat16_45 = dot(u_xlat16_3.xyz, u_xlat15.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
    u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat4.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat7.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat9.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat10.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat11.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.y = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.z = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.w = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_50 = u_xlat2.y + u_xlat2.x;
    u_xlat16_12.x = u_xlat2.z + u_xlat16_50;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat2.x);
    u_xlat7.z = (-u_xlat16_50);
    u_xlat7.w = (-u_xlat16_12.x);
    u_xlat2 = u_xlat2 + u_xlat7;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_50 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb46 = !!(u_xlat16_50>=0.5);
#else
    u_xlatb46 = u_xlat16_50>=0.5;
#endif
    if(u_xlatb46){
        u_xlat46 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat46 = min(u_xlat46, 3.0);
        u_xlatu46 = uint(u_xlat46);
        u_xlat4.xyz = u_xlat4.xyz + (-unity_ShadowPos[int(u_xlatu46)].xyz);
        u_xlati46 = int(u_xlatu46) << 2;
        u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati46 + 1)].xyz;
        u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati46].xyz * u_xlat4.xxx + u_xlat7.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati46 + 2)].xyz * u_xlat4.zzz + u_xlat7.xyz;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati46 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_4.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_18 = (-_LightShadowData.x) + 1.0;
        u_xlat4.x = u_xlat10_4.x * u_xlat16_18 + _LightShadowData.x;
    } else {
        u_xlat4.x = 1.0;
    //ENDIF
    }
    u_xlat16_50 = u_xlat4.x + -1.0;
    u_xlat16_50 = _ShadowIntensity * u_xlat16_50 + 1.0;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD6.w);
    u_xlat10_4.xyz = texture(_RefCube, u_xlat16_8.xyz).xyz;
    u_xlat16_8.x = dot(u_xlat10_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_12.xyz + _RefBackgroundColor.xyz;
    u_xlat16_12.x = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_26 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_12.x = float(1.0) / u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_26;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.x = min(max(u_xlat16_12.x, 0.0), 1.0);
#else
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_12.x * -2.0 + 3.0;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_26;
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-_GradualColor.xyz);
    u_xlat16_8.xyz = u_xlat16_12.xxx * u_xlat16_8.xyz + _GradualColor.xyz;
    u_xlat16_12.x = u_xlat14 * u_xlat16_12.x;
    u_xlat4.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 0.0);
    u_xlat14 = min(u_xlat14, _DepthFoamExtent);
    u_xlat14 = u_xlat14 / _DepthFoamExtent;
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat16_12.x = max(u_xlat14, 9.99999975e-05);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _DepthFoamAtten;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat1.x>=_FallFoamClip);
#else
    u_xlatb14 = u_xlat1.x>=_FallFoamClip;
#endif
    u_xlat18 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_26 = u_xlat10_0.z * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat16_26>=_DepthFoamClip);
#else
    u_xlatb32 = u_xlat16_26>=_DepthFoamClip;
#endif
    u_xlat16_46 = (-_BendFoamWidth) + 0.5;
    u_xlat16_46 = u_xlat16_46 + _BendFoamOffset;
    u_xlat16_47 = _BendFoamWidth + 0.5;
    u_xlat16_47 = u_xlat16_47 + _BendFoamOffset;
    u_xlat16_47 = (-u_xlat16_46) + u_xlat16_47;
    u_xlat46 = (-u_xlat16_46) + vs_TEXCOORD2.y;
    u_xlat16_47 = float(1.0) / u_xlat16_47;
    u_xlat46 = u_xlat46 * u_xlat16_47;
#ifdef UNITY_ADRENO_ES3
    u_xlat46 = min(max(u_xlat46, 0.0), 1.0);
#else
    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
#endif
    u_xlat47 = u_xlat46 * -2.0 + 3.0;
    u_xlat46 = u_xlat46 * u_xlat46;
    u_xlat46 = u_xlat47 * u_xlat46 + -0.5;
    u_xlat46 = -abs(u_xlat46) * 2.0 + 1.0;
    u_xlat16_26 = u_xlat10_0.z * u_xlat46;
#ifdef UNITY_ADRENO_ES3
    u_xlatb47 = !!(u_xlat16_26>=_BendFoamClip);
#else
    u_xlatb47 = u_xlat16_26>=_BendFoamClip;
#endif
    u_xlat7.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat48 = u_xlat7.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat10_0.z>=u_xlat48);
#else
    u_xlatb48 = u_xlat10_0.z>=u_xlat48;
#endif
    u_xlat48 = u_xlatb48 ? 1.0 : float(0.0);
    u_xlat48 = u_xlat48 * _SplashFoamColor.w;
    u_xlat35 = u_xlat7.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlat42>=u_xlat35);
#else
    u_xlatb35 = u_xlat42>=u_xlat35;
#endif
    u_xlat35 = u_xlatb35 ? 1.0 : float(0.0);
    u_xlat35 = u_xlat35 * _BottomFoamColor.w;
    u_xlat16_26 = u_xlat1.x + (-_FallFoamClip);
    u_xlat16_40 = float(1.0) / _FoamSoften;
    u_xlat16_26 = u_xlat16_40 * u_xlat16_26;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_54 = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_54;
    u_xlat1.x = u_xlat18 * u_xlat16_26;
    u_xlat16_26 = (u_xlatb14) ? u_xlat1.x : 0.0;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_12.x = u_xlat16_40 * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.x = min(max(u_xlat16_12.x, 0.0), 1.0);
#else
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
#endif
    u_xlat16_54 = u_xlat16_12.x * -2.0 + 3.0;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_54;
    u_xlat14 = u_xlat16_12.x * _DepthFoamColor.w;
    u_xlat16_12.x = (u_xlatb32) ? u_xlat14 : 0.0;
    u_xlat16_54 = u_xlat46 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_40 = u_xlat16_40 * u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat16_54 = u_xlat16_40 * -2.0 + 3.0;
    u_xlat16_40 = u_xlat16_40 * u_xlat16_40;
    u_xlat16_40 = u_xlat16_40 * u_xlat16_54;
    u_xlat14 = u_xlat16_40 * _BendFoamColor.w;
    u_xlat16_40 = (u_xlatb47) ? u_xlat14 : 0.0;
    u_xlat14 = (-u_xlat7.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_28 = float(1.0) / _FoamSoften;
    u_xlat14 = u_xlat16_28 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat14 * -2.0 + 3.0;
    u_xlat14 = u_xlat14 * u_xlat14;
    u_xlat14 = u_xlat14 * u_xlat1.x;
    u_xlat1.x = u_xlat14 * u_xlat48;
    u_xlat42 = (-u_xlat7.y) * _BottomFoamClip + u_xlat42;
    u_xlat28 = u_xlat16_28 * u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat42 = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat28 = u_xlat28 * u_xlat42;
    u_xlat42 = u_xlat28 * u_xlat35;
    u_xlat16_13.xyz = (-u_xlat16_8.xyz) + _FallFoamColor.xyz;
    u_xlat16_54 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_13.xyz + u_xlat16_8.xyz;
    u_xlat16_2.w = u_xlat16_26 * u_xlat16_54 + vs_COLOR0.x;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _DepthFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = u_xlat16_12.xxxx * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _BendFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat16_40) * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _SplashFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = u_xlat1.xxxx * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _BottomFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat42) * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9 = u_xlat16_2 * _MainColor;
    u_xlat16_8.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_8.x = log2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaRange;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaIntensity;
    SV_Target0.w = u_xlat16_8.x * u_xlat16_9.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_12.x + u_xlat16_26;
    u_xlat16_8.x = u_xlat16_40 + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat48 * u_xlat14 + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat35 * u_xlat28 + u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat16_8.x>=9.99999975e-05);
#else
    u_xlatb14 = u_xlat16_8.x>=9.99999975e-05;
#endif
    u_xlat16_8.x = (u_xlatb14) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_22 = (u_xlatb14) ? 0.0399999991 : 0.100000001;
    u_xlat16_12.xyz = vec3(u_xlat16_45) * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_12.xyz * vec3(u_xlat16_50) + vs_TEXCOORD1.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat15.xyz;
    u_xlat16_45 = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_45 = inversesqrt(u_xlat16_45);
    u_xlat16_12.xyz = vec3(u_xlat16_45) * u_xlat16_12.xyz;
    u_xlat16_0 = dot(u_xlat16_3.xyz, u_xlat16_12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat28 = dot(u_xlat15.xyz, u_xlat16_12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_42 = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_1 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_15 = u_xlat16_0 * u_xlat16_1 + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_15 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_1 / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_42 = (-u_xlat16_42) * u_xlat16_42 + 1.0;
    u_xlat16_42 = u_xlat16_42 + u_xlat16_42;
    u_xlat14 = (u_xlatb14) ? 0.959999979 : 0.899999976;
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat16_3.x = u_xlat28 * u_xlat28;
    u_xlat16_3.x = u_xlat28 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat28 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat28 * u_xlat16_3.x;
    u_xlat14 = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = u_xlat14 * u_xlat16_42 + u_xlat16_22;
    u_xlat28 = u_xlat14 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat14 + 2.0;
    u_xlat0.x = u_xlat28 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_50) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat16_9.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(_ApplyEnvironmet) * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat42 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat28 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15.x = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat15.x * u_xlat1.x;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!((-u_xlat42)>=u_xlat15.x);
#else
    u_xlatb42 = (-u_xlat42)>=u_xlat15.x;
#endif
    u_xlat15.x = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat42 = (u_xlatb42) ? u_xlat15.x : u_xlat1.x;
    u_xlat42 = log2(u_xlat42);
    u_xlat42 = u_xlat42 * unity_FogColor.w;
    u_xlat42 = exp2(u_xlat42);
    u_xlat42 = min(u_xlat42, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_45 = (-u_xlat1.x) + 2.0;
    u_xlat16_45 = u_xlat1.x * u_xlat16_45;
    u_xlat1.xyz = vec3(u_xlat16_45) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat43 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat43 = u_xlat43 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat43 = min(max(u_xlat43, 0.0), 1.0);
#else
    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat43) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat43 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat43));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat43);
#endif
    u_xlat18 = u_xlat43 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat43 = u_xlat18 / u_xlat43;
    u_xlat16_45 = (u_xlatb4) ? u_xlat43 : 1.0;
    u_xlat14 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb43 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat4.x = u_xlat14 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat14 = u_xlat4.x / u_xlat14;
    u_xlat16_8.x = (u_xlatb43) ? u_xlat14 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_45 = u_xlat28 * u_xlat16_45;
    u_xlat16_8.x = u_xlat14 * u_xlat16_8.x;
    u_xlat16_45 = exp2((-u_xlat16_45));
    u_xlat16_45 = (-u_xlat16_45) + 1.0;
    u_xlat16_45 = max(u_xlat16_45, 0.0);
    u_xlat16_8.x = exp2((-u_xlat16_8.x));
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_45 = u_xlat16_45 + u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat0.x) + 2.0;
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat16_8.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_45 = u_xlat0.x * u_xlat16_45;
    u_xlat0.x = min(u_xlat16_45, _HeigtFogColBase.w);
    u_xlat14 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat42) + 1.0;
    u_xlat0.x = u_xlat14 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
vec2 u_xlat21;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11.x = u_xlat3 * -1.44269502;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat11.x = u_xlat11.x / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11.x : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11.x = (-u_xlat3) + 1.0;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat19);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat19;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat11.xxx * u_xlat10.xyz;
    u_xlat26 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat11.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat21.x = sqrt(u_xlat26);
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat21.y = sqrt(u_xlat26);
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD3.x = u_xlat5.z;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat6.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat6.xyz = u_xlat0.xxx * u_xlat6.xyz;
    vs_TEXCOORD3.y = u_xlat6.x;
    vs_TEXCOORD3.w = u_xlat8.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat8.y;
    vs_TEXCOORD5.w = u_xlat8.z;
    vs_TEXCOORD4.y = u_xlat6.y;
    vs_TEXCOORD5.y = u_xlat6.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FallsFoamSpeed;
uniform 	mediump float _FallsFoamUScale;
uniform 	mediump float _FallsFoamVScale;
uniform 	mediump float _BottomFoamSpeed;
uniform 	mediump float _BottomFoamUScale;
uniform 	mediump float _BottomFoamVScale;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
vec4 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec4 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
float u_xlat14;
bool u_xlatb14;
vec3 u_xlat15;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_22;
mediump float u_xlat16_26;
float u_xlat28;
mediump float u_xlat16_28;
vec2 u_xlat29;
bool u_xlatb32;
float u_xlat35;
bool u_xlatb35;
mediump float u_xlat16_40;
float u_xlat42;
mediump float u_xlat16_42;
bool u_xlatb42;
float u_xlat43;
bool u_xlatb43;
mediump float u_xlat16_45;
float u_xlat46;
mediump float u_xlat16_46;
int u_xlati46;
uint u_xlatu46;
bool u_xlatb46;
float u_xlat47;
mediump float u_xlat16_47;
bool u_xlatb47;
float u_xlat48;
bool u_xlatb48;
mediump float u_xlat16_50;
mediump float u_xlat16_54;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0.xyz = texture(_BumpMap, u_xlat0.xy).xyz;
    u_xlat42 = _Time.y * _FallsFoamSpeed;
    u_xlat1.y = fract(u_xlat42);
    u_xlat1.x = float(0.0);
    u_xlat29.x = float(0.0);
    u_xlat1.xy = vec2(_FallsFoamUScale, _FallsFoamVScale) * vs_TEXCOORD2.zw + u_xlat1.xy;
    u_xlat42 = _Time.y * _BottomFoamSpeed;
    u_xlat29.y = fract(u_xlat42);
    u_xlat29.xy = vec2(_BottomFoamUScale, _BottomFoamVScale) * vs_TEXCOORD2.zw + u_xlat29.xy;
    u_xlat42 = texture(_BumpMap, u_xlat29.xy).z;
    u_xlat1.x = texture(_BumpMap, u_xlat1.xy).w;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_0 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_0);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat4.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat4.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD3.w;
    u_xlat5.y = vs_TEXCOORD4.w;
    u_xlat5.z = vs_TEXCOORD5.w;
    u_xlat15.xyz = (-u_xlat5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat15.xyz, u_xlat15.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat15.xyz = u_xlat0.xxx * u_xlat15.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat16_3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat4.xyz;
    u_xlat16_45 = dot((-u_xlat7.xyz), u_xlat16_3.xyz);
    u_xlat16_45 = u_xlat16_45 + u_xlat16_45;
    u_xlat16_8.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_45)) + (-u_xlat7.xyz);
    u_xlat16_45 = dot(u_xlat16_3.xyz, u_xlat15.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_45 = min(max(u_xlat16_45, 0.0), 1.0);
#else
    u_xlat16_45 = clamp(u_xlat16_45, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat14 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat14 = _ZBufferParams.z * u_xlat14 + _ZBufferParams.w;
    u_xlat14 = float(1.0) / u_xlat14;
    u_xlat4.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat7.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat9.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat10.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat11.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.y = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.z = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.w = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_50 = u_xlat2.y + u_xlat2.x;
    u_xlat16_12.x = u_xlat2.z + u_xlat16_50;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat2.x);
    u_xlat7.z = (-u_xlat16_50);
    u_xlat7.w = (-u_xlat16_12.x);
    u_xlat2 = u_xlat2 + u_xlat7;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_50 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb46 = !!(u_xlat16_50>=0.5);
#else
    u_xlatb46 = u_xlat16_50>=0.5;
#endif
    if(u_xlatb46){
        u_xlat46 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat46 = min(u_xlat46, 3.0);
        u_xlatu46 = uint(u_xlat46);
        u_xlat4.xyz = u_xlat4.xyz + (-unity_ShadowPos[int(u_xlatu46)].xyz);
        u_xlati46 = int(u_xlatu46) << 2;
        u_xlat7.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati46 + 1)].xyz;
        u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati46].xyz * u_xlat4.xxx + u_xlat7.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati46 + 2)].xyz * u_xlat4.zzz + u_xlat7.xyz;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati46 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_4.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_18 = (-_LightShadowData.x) + 1.0;
        u_xlat4.x = u_xlat10_4.x * u_xlat16_18 + _LightShadowData.x;
    } else {
        u_xlat4.x = 1.0;
    //ENDIF
    }
    u_xlat16_50 = u_xlat4.x + -1.0;
    u_xlat16_50 = _ShadowIntensity * u_xlat16_50 + 1.0;
    u_xlat14 = u_xlat14 + (-vs_TEXCOORD6.w);
    u_xlat10_4.xyz = texture(_RefCube, u_xlat16_8.xyz).xyz;
    u_xlat16_8.x = dot(u_xlat10_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_12.xyz + _RefBackgroundColor.xyz;
    u_xlat16_12.x = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_26 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_12.x = float(1.0) / u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_26;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.x = min(max(u_xlat16_12.x, 0.0), 1.0);
#else
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_12.x * -2.0 + 3.0;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_26;
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-_GradualColor.xyz);
    u_xlat16_8.xyz = u_xlat16_12.xxx * u_xlat16_8.xyz + _GradualColor.xyz;
    u_xlat16_12.x = u_xlat14 * u_xlat16_12.x;
    u_xlat4.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat14 = max(u_xlat14, 0.0);
    u_xlat14 = min(u_xlat14, _DepthFoamExtent);
    u_xlat14 = u_xlat14 / _DepthFoamExtent;
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat16_12.x = max(u_xlat14, 9.99999975e-05);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _DepthFoamAtten;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat1.x>=_FallFoamClip);
#else
    u_xlatb14 = u_xlat1.x>=_FallFoamClip;
#endif
    u_xlat18 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_26 = u_xlat10_0.z * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat16_26>=_DepthFoamClip);
#else
    u_xlatb32 = u_xlat16_26>=_DepthFoamClip;
#endif
    u_xlat16_46 = (-_BendFoamWidth) + 0.5;
    u_xlat16_46 = u_xlat16_46 + _BendFoamOffset;
    u_xlat16_47 = _BendFoamWidth + 0.5;
    u_xlat16_47 = u_xlat16_47 + _BendFoamOffset;
    u_xlat16_47 = (-u_xlat16_46) + u_xlat16_47;
    u_xlat46 = (-u_xlat16_46) + vs_TEXCOORD2.y;
    u_xlat16_47 = float(1.0) / u_xlat16_47;
    u_xlat46 = u_xlat46 * u_xlat16_47;
#ifdef UNITY_ADRENO_ES3
    u_xlat46 = min(max(u_xlat46, 0.0), 1.0);
#else
    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
#endif
    u_xlat47 = u_xlat46 * -2.0 + 3.0;
    u_xlat46 = u_xlat46 * u_xlat46;
    u_xlat46 = u_xlat47 * u_xlat46 + -0.5;
    u_xlat46 = -abs(u_xlat46) * 2.0 + 1.0;
    u_xlat16_26 = u_xlat10_0.z * u_xlat46;
#ifdef UNITY_ADRENO_ES3
    u_xlatb47 = !!(u_xlat16_26>=_BendFoamClip);
#else
    u_xlatb47 = u_xlat16_26>=_BendFoamClip;
#endif
    u_xlat7.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat48 = u_xlat7.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat10_0.z>=u_xlat48);
#else
    u_xlatb48 = u_xlat10_0.z>=u_xlat48;
#endif
    u_xlat48 = u_xlatb48 ? 1.0 : float(0.0);
    u_xlat48 = u_xlat48 * _SplashFoamColor.w;
    u_xlat35 = u_xlat7.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlat42>=u_xlat35);
#else
    u_xlatb35 = u_xlat42>=u_xlat35;
#endif
    u_xlat35 = u_xlatb35 ? 1.0 : float(0.0);
    u_xlat35 = u_xlat35 * _BottomFoamColor.w;
    u_xlat16_26 = u_xlat1.x + (-_FallFoamClip);
    u_xlat16_40 = float(1.0) / _FoamSoften;
    u_xlat16_26 = u_xlat16_40 * u_xlat16_26;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_54 = u_xlat16_26 * -2.0 + 3.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_54;
    u_xlat1.x = u_xlat18 * u_xlat16_26;
    u_xlat16_26 = (u_xlatb14) ? u_xlat1.x : 0.0;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_12.x = u_xlat16_40 * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.x = min(max(u_xlat16_12.x, 0.0), 1.0);
#else
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
#endif
    u_xlat16_54 = u_xlat16_12.x * -2.0 + 3.0;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_12.x * u_xlat16_54;
    u_xlat14 = u_xlat16_12.x * _DepthFoamColor.w;
    u_xlat16_12.x = (u_xlatb32) ? u_xlat14 : 0.0;
    u_xlat16_54 = u_xlat46 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_40 = u_xlat16_40 * u_xlat16_54;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat16_54 = u_xlat16_40 * -2.0 + 3.0;
    u_xlat16_40 = u_xlat16_40 * u_xlat16_40;
    u_xlat16_40 = u_xlat16_40 * u_xlat16_54;
    u_xlat14 = u_xlat16_40 * _BendFoamColor.w;
    u_xlat16_40 = (u_xlatb47) ? u_xlat14 : 0.0;
    u_xlat14 = (-u_xlat7.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_28 = float(1.0) / _FoamSoften;
    u_xlat14 = u_xlat16_28 * u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat14 * -2.0 + 3.0;
    u_xlat14 = u_xlat14 * u_xlat14;
    u_xlat14 = u_xlat14 * u_xlat1.x;
    u_xlat1.x = u_xlat14 * u_xlat48;
    u_xlat42 = (-u_xlat7.y) * _BottomFoamClip + u_xlat42;
    u_xlat28 = u_xlat16_28 * u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat42 = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat28 = u_xlat28 * u_xlat42;
    u_xlat42 = u_xlat28 * u_xlat35;
    u_xlat16_13.xyz = (-u_xlat16_8.xyz) + _FallFoamColor.xyz;
    u_xlat16_54 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_13.xyz + u_xlat16_8.xyz;
    u_xlat16_2.w = u_xlat16_26 * u_xlat16_54 + vs_COLOR0.x;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _DepthFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = u_xlat16_12.xxxx * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _BendFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat16_40) * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _SplashFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = u_xlat1.xxxx * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + _BottomFoamColor.xyz;
    u_xlat16_9.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat42) * u_xlat16_9 + u_xlat16_2;
    u_xlat16_9 = u_xlat16_2 * _MainColor;
    u_xlat16_8.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_8.x = log2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaRange;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaIntensity;
    SV_Target0.w = u_xlat16_8.x * u_xlat16_9.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_12.x + u_xlat16_26;
    u_xlat16_8.x = u_xlat16_40 + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat48 * u_xlat14 + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat35 * u_xlat28 + u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat16_8.x>=9.99999975e-05);
#else
    u_xlatb14 = u_xlat16_8.x>=9.99999975e-05;
#endif
    u_xlat16_8.x = (u_xlatb14) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_22 = (u_xlatb14) ? 0.0399999991 : 0.100000001;
    u_xlat16_12.xyz = vec3(u_xlat16_45) * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_12.xyz * vec3(u_xlat16_50) + vs_TEXCOORD1.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat15.xyz;
    u_xlat16_45 = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_45 = inversesqrt(u_xlat16_45);
    u_xlat16_12.xyz = vec3(u_xlat16_45) * u_xlat16_12.xyz;
    u_xlat16_0 = dot(u_xlat16_3.xyz, u_xlat16_12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat28 = dot(u_xlat15.xyz, u_xlat16_12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_42 = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_1 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_15 = u_xlat16_0 * u_xlat16_1 + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_15 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_1 / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_42 = (-u_xlat16_42) * u_xlat16_42 + 1.0;
    u_xlat16_42 = u_xlat16_42 + u_xlat16_42;
    u_xlat14 = (u_xlatb14) ? 0.959999979 : 0.899999976;
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat16_3.x = u_xlat28 * u_xlat28;
    u_xlat16_3.x = u_xlat28 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat28 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat28 * u_xlat16_3.x;
    u_xlat14 = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = u_xlat14 * u_xlat16_42 + u_xlat16_22;
    u_xlat28 = u_xlat14 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat14 + 2.0;
    u_xlat0.x = u_xlat28 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_50) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat16_9.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(_ApplyEnvironmet) * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat42 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat28 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat15.x = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat15.x * u_xlat1.x;
    u_xlat15.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!((-u_xlat42)>=u_xlat15.x);
#else
    u_xlatb42 = (-u_xlat42)>=u_xlat15.x;
#endif
    u_xlat15.x = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat42 = (u_xlatb42) ? u_xlat15.x : u_xlat1.x;
    u_xlat42 = log2(u_xlat42);
    u_xlat42 = u_xlat42 * unity_FogColor.w;
    u_xlat42 = exp2(u_xlat42);
    u_xlat42 = min(u_xlat42, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_45 = (-u_xlat1.x) + 2.0;
    u_xlat16_45 = u_xlat1.x * u_xlat16_45;
    u_xlat1.xyz = vec3(u_xlat16_45) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat43 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat43 = u_xlat43 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat43 = min(max(u_xlat43, 0.0), 1.0);
#else
    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat43) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat43 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat43));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat43);
#endif
    u_xlat18 = u_xlat43 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat43 = u_xlat18 / u_xlat43;
    u_xlat16_45 = (u_xlatb4) ? u_xlat43 : 1.0;
    u_xlat14 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb43 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat4.x = u_xlat14 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat14 = u_xlat4.x / u_xlat14;
    u_xlat16_8.x = (u_xlatb43) ? u_xlat14 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_45 = u_xlat28 * u_xlat16_45;
    u_xlat16_8.x = u_xlat14 * u_xlat16_8.x;
    u_xlat16_45 = exp2((-u_xlat16_45));
    u_xlat16_45 = (-u_xlat16_45) + 1.0;
    u_xlat16_45 = max(u_xlat16_45, 0.0);
    u_xlat16_8.x = exp2((-u_xlat16_8.x));
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_45 = u_xlat16_45 + u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat0.x) + 2.0;
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat16_8.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_45 = u_xlat0.x * u_xlat16_45;
    u_xlat0.x = min(u_xlat16_45, _HeigtFogColBase.w);
    u_xlat14 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat42) + 1.0;
    u_xlat0.x = u_xlat14 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat10;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat18;
vec2 u_xlat21;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat26 = u_xlat25 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.00999999978<abs(u_xlat25));
#else
    u_xlatb25 = 0.00999999978<abs(u_xlat25);
#endif
    u_xlat16_3.x = (u_xlatb25) ? u_xlat26 : 1.0;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat26 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat26 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_11 = (u_xlatb26) ? u_xlat4.x : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_3.y = (-u_xlat16_11) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat26 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat26) + 2.0;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat26 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat26 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat26) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10;
#endif
    u_xlat10 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat18 * u_xlat10;
    u_xlat18 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat18 : u_xlat10;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat10) + 2.0;
    u_xlat16_3.x = u_xlat10 * u_xlat16_3.x;
    u_xlat12.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat12.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat12.xyz;
    u_xlat12.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat25 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat25;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat25) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21.x = sqrt(u_xlat25);
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21.y = sqrt(u_xlat25);
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat7.xyz);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD3.y = u_xlat7.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat5.z;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat1.y;
    vs_TEXCOORD5.w = u_xlat1.z;
    vs_TEXCOORD4.y = u_xlat7.y;
    vs_TEXCOORD5.y = u_xlat7.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
bool u_xlatb5;
vec3 u_xlat6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_23;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat31;
mediump float u_xlat16_31;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_43;
float u_xlat46;
mediump float u_xlat16_46;
bool u_xlatb46;
mediump float u_xlat16_48;
float u_xlat49;
mediump float u_xlat16_49;
bool u_xlatb49;
float u_xlat50;
mediump float u_xlat16_50;
int u_xlati50;
uint u_xlatu50;
bool u_xlatb50;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb51;
float u_xlat52;
bool u_xlatb52;
mediump float u_xlat16_53;
mediump float u_xlat16_58;
void main()
{
    u_xlat0 = _Time.y * _Speed;
    u_xlat0 = fract(u_xlat0);
    u_xlat1.y = u_xlat0 + vs_TEXCOORD2.w;
    u_xlat1.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat1.xy);
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_1 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_1);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat46 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat5.xyz = vec3(u_xlat46) * u_xlat5.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat46 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat7.xyz = vec3(u_xlat46) * u_xlat6.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_48 = dot((-u_xlat7.xyz), u_xlat16_3.xyz);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_48;
    u_xlat16_8.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_48)) + (-u_xlat7.xyz);
    u_xlat16_48 = dot(u_xlat16_3.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_48 = min(max(u_xlat16_48, 0.0), 1.0);
#else
    u_xlat16_48 = clamp(u_xlat16_48, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat49 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat49 = _ZBufferParams.z * u_xlat49 + _ZBufferParams.w;
    u_xlat49 = float(1.0) / u_xlat49;
    u_xlat1.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat7.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat9.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat10.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat11.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.y = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.z = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.w = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_53 = u_xlat2.y + u_xlat2.x;
    u_xlat16_12.x = u_xlat2.z + u_xlat16_53;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat2.x);
    u_xlat7.z = (-u_xlat16_53);
    u_xlat7.w = (-u_xlat16_12.x);
    u_xlat2 = u_xlat2 + u_xlat7;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_53 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb50 = !!(u_xlat16_53>=0.5);
#else
    u_xlatb50 = u_xlat16_53>=0.5;
#endif
    if(u_xlatb50){
        u_xlat50 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat50 = min(u_xlat50, 3.0);
        u_xlatu50 = uint(u_xlat50);
        u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu50)].xyz);
        u_xlati50 = int(u_xlatu50) << 2;
        u_xlat7.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 1)].xyz;
        u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati50].xyz * u_xlat1.xxx + u_xlat7.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 2)].xyz * u_xlat1.zzz + u_xlat7.xyz;
        u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
        u_xlat10_1 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat1.x = u_xlat10_1 * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat1.x = 1.0;
    //ENDIF
    }
    u_xlat16_53 = u_xlat1.x + -1.0;
    u_xlat16_53 = _ShadowIntensity * u_xlat16_53 + 1.0;
    u_xlat1.x = u_xlat49 + (-vs_TEXCOORD6.w);
    u_xlat10_7.xyz = texture(_RefCube, u_xlat16_8.xyz).xyz;
    u_xlat16_8.x = dot(u_xlat10_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_12.xyz + _RefBackgroundColor.xyz;
    u_xlat16_12.x = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_27 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_13.x = float(1.0) / u_xlat16_12.x;
    u_xlat16_13.x = u_xlat16_27 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_13.x * -2.0 + 3.0;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_28;
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-_GradualColor.xyz);
    u_xlat16_8.xyz = u_xlat16_13.xxx * u_xlat16_8.xyz + _GradualColor.xyz;
    u_xlat16_13.x = u_xlat1.x * u_xlat16_13.x;
    u_xlat16 = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, _DepthFoamExtent);
    u_xlat1.x = u_xlat1.x / _DepthFoamExtent;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat16_13.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat16_13.x = log2(u_xlat16_13.x);
    u_xlat16_13.x = u_xlat16_13.x * _DepthFoamAtten;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb1 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat31 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_28 = u_xlat10_0.z * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb49 = !!(u_xlat16_28>=_DepthFoamClip);
#else
    u_xlatb49 = u_xlat16_28>=_DepthFoamClip;
#endif
    u_xlat16_50 = (-_BendFoamWidth) + 0.5;
    u_xlat16_50 = u_xlat16_50 + _BendFoamOffset;
    u_xlat16_51 = _BendFoamWidth + 0.5;
    u_xlat16_51 = u_xlat16_51 + _BendFoamOffset;
    u_xlat16_51 = (-u_xlat16_50) + u_xlat16_51;
    u_xlat50 = (-u_xlat16_50) + vs_TEXCOORD2.y;
    u_xlat16_51 = float(1.0) / u_xlat16_51;
    u_xlat50 = u_xlat50 * u_xlat16_51;
#ifdef UNITY_ADRENO_ES3
    u_xlat50 = min(max(u_xlat50, 0.0), 1.0);
#else
    u_xlat50 = clamp(u_xlat50, 0.0, 1.0);
#endif
    u_xlat51 = u_xlat50 * -2.0 + 3.0;
    u_xlat50 = u_xlat50 * u_xlat50;
    u_xlat50 = u_xlat51 * u_xlat50 + -0.5;
    u_xlat50 = -abs(u_xlat50) * 2.0 + 1.0;
    u_xlat16_28 = u_xlat10_0.z * u_xlat50;
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(u_xlat16_28>=_BendFoamClip);
#else
    u_xlatb51 = u_xlat16_28>=_BendFoamClip;
#endif
    u_xlat7.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat37 = u_xlat7.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat10_0.z>=u_xlat37);
#else
    u_xlatb37 = u_xlat10_0.z>=u_xlat37;
#endif
    u_xlat37 = u_xlatb37 ? 1.0 : float(0.0);
    u_xlat37 = u_xlat37 * _SplashFoamColor.w;
    u_xlat52 = u_xlat7.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb52 = !!(u_xlat10_0.z>=u_xlat52);
#else
    u_xlatb52 = u_xlat10_0.z>=u_xlat52;
#endif
    u_xlat52 = u_xlatb52 ? 1.0 : float(0.0);
    u_xlat52 = u_xlat52 * _BottomFoamColor.w;
    u_xlat16_28 = u_xlat10_0.w + (-_FallFoamClip);
    u_xlat16_43 = float(1.0) / _FoamSoften;
    u_xlat16_28 = u_xlat16_43 * u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_58 = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_58;
    u_xlat31 = u_xlat31 * u_xlat16_28;
    u_xlat16_28 = (u_xlatb1) ? u_xlat31 : 0.0;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_13.x = u_xlat16_43 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_58 = u_xlat16_13.x * -2.0 + 3.0;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_58;
    u_xlat1.x = u_xlat16_13.x * _DepthFoamColor.w;
    u_xlat16_13.x = (u_xlatb49) ? u_xlat1.x : 0.0;
    u_xlat16_58 = u_xlat50 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_43 = u_xlat16_43 * u_xlat16_58;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_43 = min(max(u_xlat16_43, 0.0), 1.0);
#else
    u_xlat16_43 = clamp(u_xlat16_43, 0.0, 1.0);
#endif
    u_xlat16_58 = u_xlat16_43 * -2.0 + 3.0;
    u_xlat16_43 = u_xlat16_43 * u_xlat16_43;
    u_xlat16_43 = u_xlat16_43 * u_xlat16_58;
    u_xlat1.x = u_xlat16_43 * _BendFoamColor.w;
    u_xlat16_43 = (u_xlatb51) ? u_xlat1.x : 0.0;
    u_xlat1.x = (-u_xlat7.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_31 = float(1.0) / _FoamSoften;
    u_xlat1.x = u_xlat16_31 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat49 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat49;
    u_xlat49 = u_xlat1.x * u_xlat37;
    u_xlat50 = (-u_xlat7.y) * _BottomFoamClip + u_xlat10_0.z;
    u_xlat31 = u_xlat16_31 * u_xlat50;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat50 = u_xlat31 * -2.0 + 3.0;
    u_xlat31 = u_xlat31 * u_xlat31;
    u_xlat31 = u_xlat31 * u_xlat50;
    u_xlat50 = u_xlat31 * u_xlat52;
    u_xlat16_14.xyz = (-u_xlat16_8.xyz) + _FallFoamColor.xyz;
    u_xlat16_58 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_28) * u_xlat16_14.xyz + u_xlat16_8.xyz;
    u_xlat16_0.w = u_xlat16_28 * u_xlat16_58 + vs_COLOR0.x;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _DepthFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = u_xlat16_13.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BendFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat16_43) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SplashFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat49) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BottomFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat50) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * _MainColor;
    u_xlat16_8.x = max(u_xlat16, 9.99999975e-05);
    u_xlat16_8.x = log2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaRange;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaIntensity;
    SV_Target0.w = u_xlat16_2.w * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_13.x + u_xlat16_28;
    u_xlat16_8.x = u_xlat16_43 + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat37 * u_xlat1.x + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat52 * u_xlat31 + u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_8.x>=9.99999975e-05);
#else
    u_xlatb1 = u_xlat16_8.x>=9.99999975e-05;
#endif
    u_xlat16_8.x = (u_xlatb1) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_23 = (u_xlatb1) ? 0.0399999991 : 0.100000001;
    u_xlat16_13.xyz = vec3(u_xlat16_48) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat16_13.xyz * vec3(u_xlat16_53) + vs_TEXCOORD1.xyz;
    u_xlat16_13.xyz = u_xlat6.xyz * vec3(u_xlat46) + u_xlat5.xyz;
    u_xlat16_48 = dot(u_xlat16_13.xyz, u_xlat16_13.xyz);
    u_xlat16_48 = inversesqrt(u_xlat16_48);
    u_xlat16_13.xyz = vec3(u_xlat16_48) * u_xlat16_13.xyz;
    u_xlat16_16 = dot(u_xlat16_3.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_49 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_49 + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_5 * u_xlat16_16 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = max(u_xlat16_16, 9.99999997e-07);
    u_xlat16_16 = u_xlat16_49 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat16_16 = min(u_xlat16_16, 64.0);
    u_xlat16_46 = (-u_xlat16_46) * u_xlat16_46 + 1.0;
    u_xlat16_46 = u_xlat16_46 + u_xlat16_46;
    u_xlat1.x = (u_xlatb1) ? 0.959999979 : 0.899999976;
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat16_3.x = u_xlat31 * u_xlat31;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_46 + u_xlat16_23;
    u_xlat31 = u_xlat1.x * u_xlat16_16;
    u_xlat1.x = u_xlat16_16 * u_xlat1.x + 2.0;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat16_3.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_53) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat46 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat31 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat4.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat19 * u_xlat4.x;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb46 = !!((-u_xlat46)>=u_xlat19);
#else
    u_xlatb46 = (-u_xlat46)>=u_xlat19;
#endif
    u_xlat19 = u_xlat4.x * _HeigtFogColDelta.w;
    u_xlat46 = (u_xlatb46) ? u_xlat19 : u_xlat4.x;
    u_xlat46 = log2(u_xlat46);
    u_xlat46 = u_xlat46 * unity_FogColor.w;
    u_xlat46 = exp2(u_xlat46);
    u_xlat46 = min(u_xlat46, _HeigtFogColBase.w);
    u_xlat4.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_48 = (-u_xlat4.x) + 2.0;
    u_xlat16_48 = u_xlat16_48 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat16_48) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat49 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat49 = u_xlat49 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat49 = min(max(u_xlat49, 0.0), 1.0);
#else
    u_xlat49 = clamp(u_xlat49, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat49) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat49 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat49));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat49);
#endif
    u_xlat20 = u_xlat49 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat49 = u_xlat20 / u_xlat49;
    u_xlat16_48 = (u_xlatb5) ? u_xlat49 : 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb49 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb49 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat5.x = u_xlat16 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat16 = u_xlat5.x / u_xlat16;
    u_xlat16_8.x = (u_xlatb49) ? u_xlat16 : 1.0;
    u_xlat16 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_48 = u_xlat31 * u_xlat16_48;
    u_xlat16_8.x = u_xlat16 * u_xlat16_8.x;
    u_xlat16_48 = exp2((-u_xlat16_48));
    u_xlat16_48 = (-u_xlat16_48) + 1.0;
    u_xlat16_48 = max(u_xlat16_48, 0.0);
    u_xlat16_8.x = exp2((-u_xlat16_8.x));
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_8.x;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat1.x) + 2.0;
    u_xlat16_8.x = u_xlat1.x * u_xlat16_8.x;
    u_xlat1.x = u_xlat16_8.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_48 = u_xlat1.x * u_xlat16_48;
    u_xlat1.x = min(u_xlat16_48, _HeigtFogColBase.w);
    u_xlat16 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat16) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat4.xyz = vec3(u_xlat46) * u_xlat4.xyz;
    u_xlat16 = (-u_xlat1.x) + 1.0;
    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat1.x = (-u_xlat46) + 1.0;
    u_xlat1.x = u_xlat16 * u_xlat1.x;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
vec2 u_xlat21;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11.x = u_xlat3 * -1.44269502;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat11.x = u_xlat11.x / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11.x : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11.x = (-u_xlat3) + 1.0;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat19);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat19;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat11.xxx * u_xlat10.xyz;
    u_xlat26 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat11.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat21.x = sqrt(u_xlat26);
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat21.y = sqrt(u_xlat26);
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD3.x = u_xlat5.z;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat6.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat6.xyz = u_xlat0.xxx * u_xlat6.xyz;
    vs_TEXCOORD3.y = u_xlat6.x;
    vs_TEXCOORD3.w = u_xlat8.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat8.y;
    vs_TEXCOORD5.w = u_xlat8.z;
    vs_TEXCOORD4.y = u_xlat6.y;
    vs_TEXCOORD5.y = u_xlat6.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
bool u_xlatb5;
vec3 u_xlat6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_14;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_23;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat31;
mediump float u_xlat16_31;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_43;
float u_xlat46;
mediump float u_xlat16_46;
bool u_xlatb46;
mediump float u_xlat16_48;
float u_xlat49;
mediump float u_xlat16_49;
bool u_xlatb49;
float u_xlat50;
mediump float u_xlat16_50;
int u_xlati50;
uint u_xlatu50;
bool u_xlatb50;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb51;
float u_xlat52;
bool u_xlatb52;
mediump float u_xlat16_53;
mediump float u_xlat16_58;
void main()
{
    u_xlat0 = _Time.y * _Speed;
    u_xlat0 = fract(u_xlat0);
    u_xlat1.y = u_xlat0 + vs_TEXCOORD2.w;
    u_xlat1.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat1.xy);
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_1 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_1);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat46 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat5.xyz = vec3(u_xlat46) * u_xlat5.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat46 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat7.xyz = vec3(u_xlat46) * u_xlat6.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_48 = dot((-u_xlat7.xyz), u_xlat16_3.xyz);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_48;
    u_xlat16_8.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_48)) + (-u_xlat7.xyz);
    u_xlat16_48 = dot(u_xlat16_3.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_48 = min(max(u_xlat16_48, 0.0), 1.0);
#else
    u_xlat16_48 = clamp(u_xlat16_48, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat49 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat49 = _ZBufferParams.z * u_xlat49 + _ZBufferParams.w;
    u_xlat49 = float(1.0) / u_xlat49;
    u_xlat1.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat7.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat9.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat10.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat11.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.y = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.z = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.w = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_53 = u_xlat2.y + u_xlat2.x;
    u_xlat16_12.x = u_xlat2.z + u_xlat16_53;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat2.x);
    u_xlat7.z = (-u_xlat16_53);
    u_xlat7.w = (-u_xlat16_12.x);
    u_xlat2 = u_xlat2 + u_xlat7;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_53 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb50 = !!(u_xlat16_53>=0.5);
#else
    u_xlatb50 = u_xlat16_53>=0.5;
#endif
    if(u_xlatb50){
        u_xlat50 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat50 = min(u_xlat50, 3.0);
        u_xlatu50 = uint(u_xlat50);
        u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu50)].xyz);
        u_xlati50 = int(u_xlatu50) << 2;
        u_xlat7.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 1)].xyz;
        u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati50].xyz * u_xlat1.xxx + u_xlat7.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 2)].xyz * u_xlat1.zzz + u_xlat7.xyz;
        u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
        u_xlat10_1 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat1.x = u_xlat10_1 * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat1.x = 1.0;
    //ENDIF
    }
    u_xlat16_53 = u_xlat1.x + -1.0;
    u_xlat16_53 = _ShadowIntensity * u_xlat16_53 + 1.0;
    u_xlat1.x = u_xlat49 + (-vs_TEXCOORD6.w);
    u_xlat10_7.xyz = texture(_RefCube, u_xlat16_8.xyz).xyz;
    u_xlat16_8.x = dot(u_xlat10_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_12.xyz + _RefBackgroundColor.xyz;
    u_xlat16_12.x = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_27 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_13.x = float(1.0) / u_xlat16_12.x;
    u_xlat16_13.x = u_xlat16_27 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_13.x * -2.0 + 3.0;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_28;
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-_GradualColor.xyz);
    u_xlat16_8.xyz = u_xlat16_13.xxx * u_xlat16_8.xyz + _GradualColor.xyz;
    u_xlat16_13.x = u_xlat1.x * u_xlat16_13.x;
    u_xlat16 = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, _DepthFoamExtent);
    u_xlat1.x = u_xlat1.x / _DepthFoamExtent;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat16_13.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat16_13.x = log2(u_xlat16_13.x);
    u_xlat16_13.x = u_xlat16_13.x * _DepthFoamAtten;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb1 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat31 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_28 = u_xlat10_0.z * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb49 = !!(u_xlat16_28>=_DepthFoamClip);
#else
    u_xlatb49 = u_xlat16_28>=_DepthFoamClip;
#endif
    u_xlat16_50 = (-_BendFoamWidth) + 0.5;
    u_xlat16_50 = u_xlat16_50 + _BendFoamOffset;
    u_xlat16_51 = _BendFoamWidth + 0.5;
    u_xlat16_51 = u_xlat16_51 + _BendFoamOffset;
    u_xlat16_51 = (-u_xlat16_50) + u_xlat16_51;
    u_xlat50 = (-u_xlat16_50) + vs_TEXCOORD2.y;
    u_xlat16_51 = float(1.0) / u_xlat16_51;
    u_xlat50 = u_xlat50 * u_xlat16_51;
#ifdef UNITY_ADRENO_ES3
    u_xlat50 = min(max(u_xlat50, 0.0), 1.0);
#else
    u_xlat50 = clamp(u_xlat50, 0.0, 1.0);
#endif
    u_xlat51 = u_xlat50 * -2.0 + 3.0;
    u_xlat50 = u_xlat50 * u_xlat50;
    u_xlat50 = u_xlat51 * u_xlat50 + -0.5;
    u_xlat50 = -abs(u_xlat50) * 2.0 + 1.0;
    u_xlat16_28 = u_xlat10_0.z * u_xlat50;
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(u_xlat16_28>=_BendFoamClip);
#else
    u_xlatb51 = u_xlat16_28>=_BendFoamClip;
#endif
    u_xlat7.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat37 = u_xlat7.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat10_0.z>=u_xlat37);
#else
    u_xlatb37 = u_xlat10_0.z>=u_xlat37;
#endif
    u_xlat37 = u_xlatb37 ? 1.0 : float(0.0);
    u_xlat37 = u_xlat37 * _SplashFoamColor.w;
    u_xlat52 = u_xlat7.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb52 = !!(u_xlat10_0.z>=u_xlat52);
#else
    u_xlatb52 = u_xlat10_0.z>=u_xlat52;
#endif
    u_xlat52 = u_xlatb52 ? 1.0 : float(0.0);
    u_xlat52 = u_xlat52 * _BottomFoamColor.w;
    u_xlat16_28 = u_xlat10_0.w + (-_FallFoamClip);
    u_xlat16_43 = float(1.0) / _FoamSoften;
    u_xlat16_28 = u_xlat16_43 * u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_58 = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_58;
    u_xlat31 = u_xlat31 * u_xlat16_28;
    u_xlat16_28 = (u_xlatb1) ? u_xlat31 : 0.0;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_13.x = u_xlat16_43 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_58 = u_xlat16_13.x * -2.0 + 3.0;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_13.x;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_58;
    u_xlat1.x = u_xlat16_13.x * _DepthFoamColor.w;
    u_xlat16_13.x = (u_xlatb49) ? u_xlat1.x : 0.0;
    u_xlat16_58 = u_xlat50 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_43 = u_xlat16_43 * u_xlat16_58;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_43 = min(max(u_xlat16_43, 0.0), 1.0);
#else
    u_xlat16_43 = clamp(u_xlat16_43, 0.0, 1.0);
#endif
    u_xlat16_58 = u_xlat16_43 * -2.0 + 3.0;
    u_xlat16_43 = u_xlat16_43 * u_xlat16_43;
    u_xlat16_43 = u_xlat16_43 * u_xlat16_58;
    u_xlat1.x = u_xlat16_43 * _BendFoamColor.w;
    u_xlat16_43 = (u_xlatb51) ? u_xlat1.x : 0.0;
    u_xlat1.x = (-u_xlat7.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_31 = float(1.0) / _FoamSoften;
    u_xlat1.x = u_xlat16_31 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat49 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat49;
    u_xlat49 = u_xlat1.x * u_xlat37;
    u_xlat50 = (-u_xlat7.y) * _BottomFoamClip + u_xlat10_0.z;
    u_xlat31 = u_xlat16_31 * u_xlat50;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat50 = u_xlat31 * -2.0 + 3.0;
    u_xlat31 = u_xlat31 * u_xlat31;
    u_xlat31 = u_xlat31 * u_xlat50;
    u_xlat50 = u_xlat31 * u_xlat52;
    u_xlat16_14.xyz = (-u_xlat16_8.xyz) + _FallFoamColor.xyz;
    u_xlat16_58 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_28) * u_xlat16_14.xyz + u_xlat16_8.xyz;
    u_xlat16_0.w = u_xlat16_28 * u_xlat16_58 + vs_COLOR0.x;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _DepthFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = u_xlat16_13.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BendFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat16_43) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SplashFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat49) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BottomFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat50) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * _MainColor;
    u_xlat16_8.x = max(u_xlat16, 9.99999975e-05);
    u_xlat16_8.x = log2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaRange;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_8.x = u_xlat16_8.x * _AlphaIntensity;
    SV_Target0.w = u_xlat16_2.w * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_13.x + u_xlat16_28;
    u_xlat16_8.x = u_xlat16_43 + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat37 * u_xlat1.x + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat52 * u_xlat31 + u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_8.x>=9.99999975e-05);
#else
    u_xlatb1 = u_xlat16_8.x>=9.99999975e-05;
#endif
    u_xlat16_8.x = (u_xlatb1) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_23 = (u_xlatb1) ? 0.0399999991 : 0.100000001;
    u_xlat16_13.xyz = vec3(u_xlat16_48) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat16_13.xyz * vec3(u_xlat16_53) + vs_TEXCOORD1.xyz;
    u_xlat16_13.xyz = u_xlat6.xyz * vec3(u_xlat46) + u_xlat5.xyz;
    u_xlat16_48 = dot(u_xlat16_13.xyz, u_xlat16_13.xyz);
    u_xlat16_48 = inversesqrt(u_xlat16_48);
    u_xlat16_13.xyz = vec3(u_xlat16_48) * u_xlat16_13.xyz;
    u_xlat16_16 = dot(u_xlat16_3.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_49 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_49 + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_5 * u_xlat16_16 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = max(u_xlat16_16, 9.99999997e-07);
    u_xlat16_16 = u_xlat16_49 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat16_16 = min(u_xlat16_16, 64.0);
    u_xlat16_46 = (-u_xlat16_46) * u_xlat16_46 + 1.0;
    u_xlat16_46 = u_xlat16_46 + u_xlat16_46;
    u_xlat1.x = (u_xlatb1) ? 0.959999979 : 0.899999976;
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat16_3.x = u_xlat31 * u_xlat31;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_46 + u_xlat16_23;
    u_xlat31 = u_xlat1.x * u_xlat16_16;
    u_xlat1.x = u_xlat16_16 * u_xlat1.x + 2.0;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat16_3.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_53) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat46 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat31 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat4.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat19 * u_xlat4.x;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb46 = !!((-u_xlat46)>=u_xlat19);
#else
    u_xlatb46 = (-u_xlat46)>=u_xlat19;
#endif
    u_xlat19 = u_xlat4.x * _HeigtFogColDelta.w;
    u_xlat46 = (u_xlatb46) ? u_xlat19 : u_xlat4.x;
    u_xlat46 = log2(u_xlat46);
    u_xlat46 = u_xlat46 * unity_FogColor.w;
    u_xlat46 = exp2(u_xlat46);
    u_xlat46 = min(u_xlat46, _HeigtFogColBase.w);
    u_xlat4.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_48 = (-u_xlat4.x) + 2.0;
    u_xlat16_48 = u_xlat16_48 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat16_48) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat49 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat49 = u_xlat49 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat49 = min(max(u_xlat49, 0.0), 1.0);
#else
    u_xlat49 = clamp(u_xlat49, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat49) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat49 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat49));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat49);
#endif
    u_xlat20 = u_xlat49 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat49 = u_xlat20 / u_xlat49;
    u_xlat16_48 = (u_xlatb5) ? u_xlat49 : 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb49 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb49 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat5.x = u_xlat16 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat16 = u_xlat5.x / u_xlat16;
    u_xlat16_8.x = (u_xlatb49) ? u_xlat16 : 1.0;
    u_xlat16 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_48 = u_xlat31 * u_xlat16_48;
    u_xlat16_8.x = u_xlat16 * u_xlat16_8.x;
    u_xlat16_48 = exp2((-u_xlat16_48));
    u_xlat16_48 = (-u_xlat16_48) + 1.0;
    u_xlat16_48 = max(u_xlat16_48, 0.0);
    u_xlat16_8.x = exp2((-u_xlat16_8.x));
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_8.x;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = (-u_xlat1.x) + 2.0;
    u_xlat16_8.x = u_xlat1.x * u_xlat16_8.x;
    u_xlat1.x = u_xlat16_8.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_48 = u_xlat1.x * u_xlat16_48;
    u_xlat1.x = min(u_xlat16_48, _HeigtFogColBase.w);
    u_xlat16 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat16) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat4.xyz = vec3(u_xlat46) * u_xlat4.xyz;
    u_xlat16 = (-u_xlat1.x) + 1.0;
    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat1.x = (-u_xlat46) + 1.0;
    u_xlat1.x = u_xlat16 * u_xlat1.x;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat10;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat18;
vec2 u_xlat21;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat26 = u_xlat25 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.00999999978<abs(u_xlat25));
#else
    u_xlatb25 = 0.00999999978<abs(u_xlat25);
#endif
    u_xlat16_3.x = (u_xlatb25) ? u_xlat26 : 1.0;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat26 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat26 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_11 = (u_xlatb26) ? u_xlat4.x : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_3.y = (-u_xlat16_11) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat26 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat26) + 2.0;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat26 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat26 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat26) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10;
#endif
    u_xlat10 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat18 * u_xlat10;
    u_xlat18 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat18 : u_xlat10;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat10) + 2.0;
    u_xlat16_3.x = u_xlat10 * u_xlat16_3.x;
    u_xlat12.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat12.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat12.xyz;
    u_xlat12.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat25 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat25;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat25) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21.x = sqrt(u_xlat25);
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21.y = sqrt(u_xlat25);
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat7.xyz);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD3.y = u_xlat7.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat5.z;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat1.y;
    vs_TEXCOORD5.w = u_xlat1.z;
    vs_TEXCOORD4.y = u_xlat7.y;
    vs_TEXCOORD5.y = u_xlat7.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
bool u_xlatb5;
vec3 u_xlat6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump float u_xlat16_14;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat19;
float u_xlat20;
mediump vec3 u_xlat16_27;
mediump vec3 u_xlat16_28;
float u_xlat31;
mediump float u_xlat16_31;
bool u_xlatb31;
float u_xlat46;
mediump float u_xlat16_46;
bool u_xlatb46;
mediump float u_xlat16_48;
float u_xlat49;
mediump float u_xlat16_49;
bool u_xlatb49;
float u_xlat50;
int u_xlati50;
uint u_xlatu50;
bool u_xlatb50;
float u_xlat51;
mediump float u_xlat16_53;
mediump float u_xlat16_57;
void main()
{
    u_xlat0 = _Time.y * _Speed;
    u_xlat0 = fract(u_xlat0);
    u_xlat1.y = u_xlat0 + vs_TEXCOORD2.w;
    u_xlat1.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat1.xy);
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_1 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_1);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat46 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat5.xyz = vec3(u_xlat46) * u_xlat5.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat46 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat7.xyz = vec3(u_xlat46) * u_xlat6.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_48 = dot((-u_xlat7.xyz), u_xlat16_3.xyz);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_48;
    u_xlat16_8.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_48)) + (-u_xlat7.xyz);
    u_xlat16_48 = dot(u_xlat16_3.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_48 = min(max(u_xlat16_48, 0.0), 1.0);
#else
    u_xlat16_48 = clamp(u_xlat16_48, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat49 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat49 = _ZBufferParams.z * u_xlat49 + _ZBufferParams.w;
    u_xlat49 = float(1.0) / u_xlat49;
    u_xlat1.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat7.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat9.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat10.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat11.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.y = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.z = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.w = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_53 = u_xlat2.y + u_xlat2.x;
    u_xlat16_12.x = u_xlat2.z + u_xlat16_53;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat2.x);
    u_xlat7.z = (-u_xlat16_53);
    u_xlat7.w = (-u_xlat16_12.x);
    u_xlat2 = u_xlat2 + u_xlat7;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_53 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb50 = !!(u_xlat16_53>=0.5);
#else
    u_xlatb50 = u_xlat16_53>=0.5;
#endif
    if(u_xlatb50){
        u_xlat50 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat50 = min(u_xlat50, 3.0);
        u_xlatu50 = uint(u_xlat50);
        u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu50)].xyz);
        u_xlati50 = int(u_xlatu50) << 2;
        u_xlat7.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 1)].xyz;
        u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati50].xyz * u_xlat1.xxx + u_xlat7.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 2)].xyz * u_xlat1.zzz + u_xlat7.xyz;
        u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
        u_xlat10_1 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat1.x = u_xlat10_1 * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat1.x = 1.0;
    //ENDIF
    }
    u_xlat16_53 = u_xlat1.x + -1.0;
    u_xlat16_53 = _ShadowIntensity * u_xlat16_53 + 1.0;
    u_xlat1.x = u_xlat49 + (-vs_TEXCOORD6.w);
    u_xlat10_7.xyz = texture(_RefCube, u_xlat16_8.xyz).xyz;
    u_xlat16_12.x = dot(u_xlat10_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.x = min(max(u_xlat16_12.x, 0.0), 1.0);
#else
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
#endif
    u_xlat16_27.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_27.xyz + _RefBackgroundColor.xyz;
    u_xlat16_57 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_13.x = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_57 = float(1.0) / u_xlat16_57;
    u_xlat16_57 = u_xlat16_57 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_57 = min(max(u_xlat16_57, 0.0), 1.0);
#else
    u_xlat16_57 = clamp(u_xlat16_57, 0.0, 1.0);
#endif
    u_xlat16_13.x = u_xlat16_57 * -2.0 + 3.0;
    u_xlat16_57 = u_xlat16_57 * u_xlat16_57;
    u_xlat16_57 = u_xlat16_57 * u_xlat16_13.x;
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-_GradualColor.xyz);
    u_xlat16_12.xyz = vec3(u_xlat16_57) * u_xlat16_12.xyz + _GradualColor.xyz;
    u_xlat16_57 = u_xlat1.x * u_xlat16_57;
    u_xlat16 = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16_57;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, _DepthFoamExtent);
    u_xlat1.x = u_xlat1.x / _DepthFoamExtent;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat16_57 = max(u_xlat1.x, 9.99999975e-05);
    u_xlat16_57 = log2(u_xlat16_57);
    u_xlat16_57 = u_xlat16_57 * _DepthFoamAtten;
    u_xlat16_57 = exp2(u_xlat16_57);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb1 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat31 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat1.x = u_xlatb1 ? u_xlat31 : float(0.0);
    u_xlat16_57 = u_xlat10_0.z * u_xlat16_57;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat16_57>=_DepthFoamClip);
#else
    u_xlatb31 = u_xlat16_57>=_DepthFoamClip;
#endif
    u_xlat16_57 = (u_xlatb31) ? _DepthFoamColor.w : 0.0;
    u_xlat16_31 = (-_BendFoamWidth) + 0.5;
    u_xlat16_31 = u_xlat16_31 + _BendFoamOffset;
    u_xlat16_49 = _BendFoamWidth + 0.5;
    u_xlat16_49 = u_xlat16_49 + _BendFoamOffset;
    u_xlat16_49 = (-u_xlat16_31) + u_xlat16_49;
    u_xlat31 = (-u_xlat16_31) + vs_TEXCOORD2.y;
    u_xlat16_49 = float(1.0) / u_xlat16_49;
    u_xlat31 = u_xlat31 * u_xlat16_49;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat49 = u_xlat31 * -2.0 + 3.0;
    u_xlat31 = u_xlat31 * u_xlat31;
    u_xlat31 = u_xlat49 * u_xlat31 + -0.5;
    u_xlat31 = -abs(u_xlat31) * 2.0 + 1.0;
    u_xlat16_13.x = u_xlat10_0.z * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat16_13.x>=_BendFoamClip);
#else
    u_xlatb31 = u_xlat16_13.x>=_BendFoamClip;
#endif
    u_xlat16_13.x = (u_xlatb31) ? _BendFoamColor.w : 0.0;
    u_xlat7.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat31 = u_xlat7.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat10_0.z>=u_xlat31);
#else
    u_xlatb31 = u_xlat10_0.z>=u_xlat31;
#endif
    u_xlat31 = u_xlatb31 ? 1.0 : float(0.0);
    u_xlat49 = u_xlat31 * _SplashFoamColor.w;
    u_xlat50 = u_xlat7.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb50 = !!(u_xlat10_0.z>=u_xlat50);
#else
    u_xlatb50 = u_xlat10_0.z>=u_xlat50;
#endif
    u_xlat50 = u_xlatb50 ? 1.0 : float(0.0);
    u_xlat51 = u_xlat50 * _BottomFoamColor.w;
    u_xlat16_28.xyz = (-u_xlat16_12.xyz) + _FallFoamColor.xyz;
    u_xlat16_14 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_28.xyz + u_xlat16_12.xyz;
    u_xlat16_0.w = u_xlat1.x * u_xlat16_14 + vs_COLOR0.x;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _DepthFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat16_57) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BendFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = u_xlat16_13.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SplashFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat49) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BottomFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat51) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * _MainColor;
    u_xlat16_12.x = max(u_xlat16, 9.99999975e-05);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _AlphaRange;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _AlphaIntensity;
    SV_Target0.w = u_xlat16_2.w * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat1.x + u_xlat16_57;
    u_xlat16_12.x = u_xlat16_13.x + u_xlat16_12.x;
    u_xlat16_12.x = u_xlat31 * _SplashFoamColor.w + u_xlat16_12.x;
    u_xlat16_12.x = u_xlat50 * _BottomFoamColor.w + u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_12.x>=9.99999975e-05);
#else
    u_xlatb1 = u_xlat16_12.x>=9.99999975e-05;
#endif
    u_xlat16_12.x = (u_xlatb1) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_27.x = (u_xlatb1) ? 0.0399999991 : 0.100000001;
    u_xlat16_13.xyz = vec3(u_xlat16_48) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat16_13.xyz * vec3(u_xlat16_53) + vs_TEXCOORD1.xyz;
    u_xlat16_13.xyz = u_xlat6.xyz * vec3(u_xlat46) + u_xlat5.xyz;
    u_xlat16_48 = dot(u_xlat16_13.xyz, u_xlat16_13.xyz);
    u_xlat16_48 = inversesqrt(u_xlat16_48);
    u_xlat16_13.xyz = vec3(u_xlat16_48) * u_xlat16_13.xyz;
    u_xlat16_16 = dot(u_xlat16_3.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_12.x * u_xlat16_12.x;
    u_xlat16_49 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_49 + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_5 * u_xlat16_16 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = max(u_xlat16_16, 9.99999997e-07);
    u_xlat16_16 = u_xlat16_49 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat16_16 = min(u_xlat16_16, 64.0);
    u_xlat16_46 = (-u_xlat16_46) * u_xlat16_46 + 1.0;
    u_xlat16_46 = u_xlat16_46 + u_xlat16_46;
    u_xlat1.x = (u_xlatb1) ? 0.959999979 : 0.899999976;
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat16_3.x = u_xlat31 * u_xlat31;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_46 + u_xlat16_27.x;
    u_xlat31 = u_xlat1.x * u_xlat16_16;
    u_xlat1.x = u_xlat16_16 * u_xlat1.x + 2.0;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat16_3.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_53) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat46 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat31 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat4.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat19 * u_xlat4.x;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb46 = !!((-u_xlat46)>=u_xlat19);
#else
    u_xlatb46 = (-u_xlat46)>=u_xlat19;
#endif
    u_xlat19 = u_xlat4.x * _HeigtFogColDelta.w;
    u_xlat46 = (u_xlatb46) ? u_xlat19 : u_xlat4.x;
    u_xlat46 = log2(u_xlat46);
    u_xlat46 = u_xlat46 * unity_FogColor.w;
    u_xlat46 = exp2(u_xlat46);
    u_xlat46 = min(u_xlat46, _HeigtFogColBase.w);
    u_xlat4.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_48 = (-u_xlat4.x) + 2.0;
    u_xlat16_48 = u_xlat16_48 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat16_48) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat49 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat49 = u_xlat49 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat49 = min(max(u_xlat49, 0.0), 1.0);
#else
    u_xlat49 = clamp(u_xlat49, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat49) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat49 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat49));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat49);
#endif
    u_xlat20 = u_xlat49 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat49 = u_xlat20 / u_xlat49;
    u_xlat16_48 = (u_xlatb5) ? u_xlat49 : 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb49 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb49 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat5.x = u_xlat16 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat16 = u_xlat5.x / u_xlat16;
    u_xlat16_12.x = (u_xlatb49) ? u_xlat16 : 1.0;
    u_xlat16 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_48 = u_xlat31 * u_xlat16_48;
    u_xlat16_12.x = u_xlat16 * u_xlat16_12.x;
    u_xlat16_48 = exp2((-u_xlat16_48));
    u_xlat16_48 = (-u_xlat16_48) + 1.0;
    u_xlat16_48 = max(u_xlat16_48, 0.0);
    u_xlat16_12.x = exp2((-u_xlat16_12.x));
    u_xlat16_12.x = (-u_xlat16_12.x) + 1.0;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_12.x;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = (-u_xlat1.x) + 2.0;
    u_xlat16_12.x = u_xlat1.x * u_xlat16_12.x;
    u_xlat1.x = u_xlat16_12.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_48 = u_xlat1.x * u_xlat16_48;
    u_xlat1.x = min(u_xlat16_48, _HeigtFogColBase.w);
    u_xlat16 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat16) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat4.xyz = vec3(u_xlat46) * u_xlat4.xyz;
    u_xlat16 = (-u_xlat1.x) + 1.0;
    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat1.x = (-u_xlat46) + 1.0;
    u_xlat1.x = u_xlat16 * u_xlat1.x;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
vec2 u_xlat21;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11.x = u_xlat3 * -1.44269502;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat11.x = u_xlat11.x / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11.x : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11.x = (-u_xlat3) + 1.0;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat19);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat19;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat11.xxx * u_xlat10.xyz;
    u_xlat26 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat11.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat21.x = sqrt(u_xlat26);
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat21.y = sqrt(u_xlat26);
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD3.x = u_xlat5.z;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat6.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat6.xyz = u_xlat0.xxx * u_xlat6.xyz;
    vs_TEXCOORD3.y = u_xlat6.x;
    vs_TEXCOORD3.w = u_xlat8.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat8.y;
    vs_TEXCOORD5.w = u_xlat8.z;
    vs_TEXCOORD4.y = u_xlat6.y;
    vs_TEXCOORD5.y = u_xlat6.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
bool u_xlatb5;
vec3 u_xlat6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
mediump float u_xlat16_14;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat19;
float u_xlat20;
mediump vec3 u_xlat16_27;
mediump vec3 u_xlat16_28;
float u_xlat31;
mediump float u_xlat16_31;
bool u_xlatb31;
float u_xlat46;
mediump float u_xlat16_46;
bool u_xlatb46;
mediump float u_xlat16_48;
float u_xlat49;
mediump float u_xlat16_49;
bool u_xlatb49;
float u_xlat50;
int u_xlati50;
uint u_xlatu50;
bool u_xlatb50;
float u_xlat51;
mediump float u_xlat16_53;
mediump float u_xlat16_57;
void main()
{
    u_xlat0 = _Time.y * _Speed;
    u_xlat0 = fract(u_xlat0);
    u_xlat1.y = u_xlat0 + vs_TEXCOORD2.w;
    u_xlat1.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat1.xy);
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_1 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_1);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat46 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat5.xyz = vec3(u_xlat46) * u_xlat5.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat46 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat46 = inversesqrt(u_xlat46);
    u_xlat7.xyz = vec3(u_xlat46) * u_xlat6.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_48 = dot((-u_xlat7.xyz), u_xlat16_3.xyz);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_48;
    u_xlat16_8.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_48)) + (-u_xlat7.xyz);
    u_xlat16_48 = dot(u_xlat16_3.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_48 = min(max(u_xlat16_48, 0.0), 1.0);
#else
    u_xlat16_48 = clamp(u_xlat16_48, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat49 = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat49 = _ZBufferParams.z * u_xlat49 + _ZBufferParams.w;
    u_xlat49 = float(1.0) / u_xlat49;
    u_xlat1.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat7.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat9.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat10.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat11.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.y = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.z = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.w = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_53 = u_xlat2.y + u_xlat2.x;
    u_xlat16_12.x = u_xlat2.z + u_xlat16_53;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat2.x);
    u_xlat7.z = (-u_xlat16_53);
    u_xlat7.w = (-u_xlat16_12.x);
    u_xlat2 = u_xlat2 + u_xlat7;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_53 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb50 = !!(u_xlat16_53>=0.5);
#else
    u_xlatb50 = u_xlat16_53>=0.5;
#endif
    if(u_xlatb50){
        u_xlat50 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat50 = min(u_xlat50, 3.0);
        u_xlatu50 = uint(u_xlat50);
        u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu50)].xyz);
        u_xlati50 = int(u_xlatu50) << 2;
        u_xlat7.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 1)].xyz;
        u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati50].xyz * u_xlat1.xxx + u_xlat7.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 2)].xyz * u_xlat1.zzz + u_xlat7.xyz;
        u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati50 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
        u_xlat10_1 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat1.x = u_xlat10_1 * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat1.x = 1.0;
    //ENDIF
    }
    u_xlat16_53 = u_xlat1.x + -1.0;
    u_xlat16_53 = _ShadowIntensity * u_xlat16_53 + 1.0;
    u_xlat1.x = u_xlat49 + (-vs_TEXCOORD6.w);
    u_xlat10_7.xyz = texture(_RefCube, u_xlat16_8.xyz).xyz;
    u_xlat16_12.x = dot(u_xlat10_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.x = min(max(u_xlat16_12.x, 0.0), 1.0);
#else
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
#endif
    u_xlat16_27.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_27.xyz + _RefBackgroundColor.xyz;
    u_xlat16_57 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_13.x = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_57 = float(1.0) / u_xlat16_57;
    u_xlat16_57 = u_xlat16_57 * u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_57 = min(max(u_xlat16_57, 0.0), 1.0);
#else
    u_xlat16_57 = clamp(u_xlat16_57, 0.0, 1.0);
#endif
    u_xlat16_13.x = u_xlat16_57 * -2.0 + 3.0;
    u_xlat16_57 = u_xlat16_57 * u_xlat16_57;
    u_xlat16_57 = u_xlat16_57 * u_xlat16_13.x;
    u_xlat16_12.xyz = u_xlat16_12.xyz + (-_GradualColor.xyz);
    u_xlat16_12.xyz = vec3(u_xlat16_57) * u_xlat16_12.xyz + _GradualColor.xyz;
    u_xlat16_57 = u_xlat1.x * u_xlat16_57;
    u_xlat16 = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16_57;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, _DepthFoamExtent);
    u_xlat1.x = u_xlat1.x / _DepthFoamExtent;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat16_57 = max(u_xlat1.x, 9.99999975e-05);
    u_xlat16_57 = log2(u_xlat16_57);
    u_xlat16_57 = u_xlat16_57 * _DepthFoamAtten;
    u_xlat16_57 = exp2(u_xlat16_57);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb1 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat31 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat1.x = u_xlatb1 ? u_xlat31 : float(0.0);
    u_xlat16_57 = u_xlat10_0.z * u_xlat16_57;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat16_57>=_DepthFoamClip);
#else
    u_xlatb31 = u_xlat16_57>=_DepthFoamClip;
#endif
    u_xlat16_57 = (u_xlatb31) ? _DepthFoamColor.w : 0.0;
    u_xlat16_31 = (-_BendFoamWidth) + 0.5;
    u_xlat16_31 = u_xlat16_31 + _BendFoamOffset;
    u_xlat16_49 = _BendFoamWidth + 0.5;
    u_xlat16_49 = u_xlat16_49 + _BendFoamOffset;
    u_xlat16_49 = (-u_xlat16_31) + u_xlat16_49;
    u_xlat31 = (-u_xlat16_31) + vs_TEXCOORD2.y;
    u_xlat16_49 = float(1.0) / u_xlat16_49;
    u_xlat31 = u_xlat31 * u_xlat16_49;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat49 = u_xlat31 * -2.0 + 3.0;
    u_xlat31 = u_xlat31 * u_xlat31;
    u_xlat31 = u_xlat49 * u_xlat31 + -0.5;
    u_xlat31 = -abs(u_xlat31) * 2.0 + 1.0;
    u_xlat16_13.x = u_xlat10_0.z * u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat16_13.x>=_BendFoamClip);
#else
    u_xlatb31 = u_xlat16_13.x>=_BendFoamClip;
#endif
    u_xlat16_13.x = (u_xlatb31) ? _BendFoamColor.w : 0.0;
    u_xlat7.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat31 = u_xlat7.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat10_0.z>=u_xlat31);
#else
    u_xlatb31 = u_xlat10_0.z>=u_xlat31;
#endif
    u_xlat31 = u_xlatb31 ? 1.0 : float(0.0);
    u_xlat49 = u_xlat31 * _SplashFoamColor.w;
    u_xlat50 = u_xlat7.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb50 = !!(u_xlat10_0.z>=u_xlat50);
#else
    u_xlatb50 = u_xlat10_0.z>=u_xlat50;
#endif
    u_xlat50 = u_xlatb50 ? 1.0 : float(0.0);
    u_xlat51 = u_xlat50 * _BottomFoamColor.w;
    u_xlat16_28.xyz = (-u_xlat16_12.xyz) + _FallFoamColor.xyz;
    u_xlat16_14 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_28.xyz + u_xlat16_12.xyz;
    u_xlat16_0.w = u_xlat1.x * u_xlat16_14 + vs_COLOR0.x;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _DepthFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat16_57) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BendFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = u_xlat16_13.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SplashFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat49) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _BottomFoamColor.xyz;
    u_xlat16_2.w = (-u_xlat16_0.w) + 1.0;
    u_xlat16_0 = vec4(u_xlat51) * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * _MainColor;
    u_xlat16_12.x = max(u_xlat16, 9.99999975e-05);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _AlphaRange;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _AlphaIntensity;
    SV_Target0.w = u_xlat16_2.w * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat1.x + u_xlat16_57;
    u_xlat16_12.x = u_xlat16_13.x + u_xlat16_12.x;
    u_xlat16_12.x = u_xlat31 * _SplashFoamColor.w + u_xlat16_12.x;
    u_xlat16_12.x = u_xlat50 * _BottomFoamColor.w + u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_12.x>=9.99999975e-05);
#else
    u_xlatb1 = u_xlat16_12.x>=9.99999975e-05;
#endif
    u_xlat16_12.x = (u_xlatb1) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_27.x = (u_xlatb1) ? 0.0399999991 : 0.100000001;
    u_xlat16_13.xyz = vec3(u_xlat16_48) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat16_13.xyz * vec3(u_xlat16_53) + vs_TEXCOORD1.xyz;
    u_xlat16_13.xyz = u_xlat6.xyz * vec3(u_xlat46) + u_xlat5.xyz;
    u_xlat16_48 = dot(u_xlat16_13.xyz, u_xlat16_13.xyz);
    u_xlat16_48 = inversesqrt(u_xlat16_48);
    u_xlat16_13.xyz = vec3(u_xlat16_48) * u_xlat16_13.xyz;
    u_xlat16_16 = dot(u_xlat16_3.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat16_13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_12.x * u_xlat16_12.x;
    u_xlat16_49 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_49 + (-u_xlat16_16);
    u_xlat16_16 = u_xlat16_5 * u_xlat16_16 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = max(u_xlat16_16, 9.99999997e-07);
    u_xlat16_16 = u_xlat16_49 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat16_16 = min(u_xlat16_16, 64.0);
    u_xlat16_46 = (-u_xlat16_46) * u_xlat16_46 + 1.0;
    u_xlat16_46 = u_xlat16_46 + u_xlat16_46;
    u_xlat1.x = (u_xlatb1) ? 0.959999979 : 0.899999976;
    u_xlat31 = (-u_xlat31) + 1.0;
    u_xlat16_3.x = u_xlat31 * u_xlat31;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat31 * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_46 + u_xlat16_27.x;
    u_xlat31 = u_xlat1.x * u_xlat16_16;
    u_xlat1.x = u_xlat16_16 * u_xlat1.x + 2.0;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat16_3.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_53) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat46 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat31 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat4.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat19 * u_xlat4.x;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb46 = !!((-u_xlat46)>=u_xlat19);
#else
    u_xlatb46 = (-u_xlat46)>=u_xlat19;
#endif
    u_xlat19 = u_xlat4.x * _HeigtFogColDelta.w;
    u_xlat46 = (u_xlatb46) ? u_xlat19 : u_xlat4.x;
    u_xlat46 = log2(u_xlat46);
    u_xlat46 = u_xlat46 * unity_FogColor.w;
    u_xlat46 = exp2(u_xlat46);
    u_xlat46 = min(u_xlat46, _HeigtFogColBase.w);
    u_xlat4.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_48 = (-u_xlat4.x) + 2.0;
    u_xlat16_48 = u_xlat16_48 * u_xlat4.x;
    u_xlat4.xyz = vec3(u_xlat16_48) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat49 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat49 = u_xlat49 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat49 = min(max(u_xlat49, 0.0), 1.0);
#else
    u_xlat49 = clamp(u_xlat49, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat49) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat49 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat49));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat49);
#endif
    u_xlat20 = u_xlat49 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat49 = u_xlat20 / u_xlat49;
    u_xlat16_48 = (u_xlatb5) ? u_xlat49 : 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb49 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb49 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat5.x = u_xlat16 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat16 = u_xlat5.x / u_xlat16;
    u_xlat16_12.x = (u_xlatb49) ? u_xlat16 : 1.0;
    u_xlat16 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_48 = u_xlat31 * u_xlat16_48;
    u_xlat16_12.x = u_xlat16 * u_xlat16_12.x;
    u_xlat16_48 = exp2((-u_xlat16_48));
    u_xlat16_48 = (-u_xlat16_48) + 1.0;
    u_xlat16_48 = max(u_xlat16_48, 0.0);
    u_xlat16_12.x = exp2((-u_xlat16_12.x));
    u_xlat16_12.x = (-u_xlat16_12.x) + 1.0;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_48 = u_xlat16_48 + u_xlat16_12.x;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = (-u_xlat1.x) + 2.0;
    u_xlat16_12.x = u_xlat1.x * u_xlat16_12.x;
    u_xlat1.x = u_xlat16_12.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_48 = u_xlat1.x * u_xlat16_48;
    u_xlat1.x = min(u_xlat16_48, _HeigtFogColBase.w);
    u_xlat16 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat16) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat4.xyz = vec3(u_xlat46) * u_xlat4.xyz;
    u_xlat16 = (-u_xlat1.x) + 1.0;
    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat1.x = (-u_xlat46) + 1.0;
    u_xlat1.x = u_xlat16 * u_xlat1.x;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat10;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat18;
vec2 u_xlat21;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat26 = u_xlat25 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.00999999978<abs(u_xlat25));
#else
    u_xlatb25 = 0.00999999978<abs(u_xlat25);
#endif
    u_xlat16_3.x = (u_xlatb25) ? u_xlat26 : 1.0;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat26 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat26 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_11 = (u_xlatb26) ? u_xlat4.x : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_3.y = (-u_xlat16_11) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat26 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat26) + 2.0;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat26 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat26 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat26) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10;
#endif
    u_xlat10 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat18 * u_xlat10;
    u_xlat18 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat18 : u_xlat10;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat10) + 2.0;
    u_xlat16_3.x = u_xlat10 * u_xlat16_3.x;
    u_xlat12.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat12.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat12.xyz;
    u_xlat12.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat25 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat25;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat25) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21.x = sqrt(u_xlat25);
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21.y = sqrt(u_xlat25);
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat7.xyz);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD3.y = u_xlat7.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat5.z;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat1.y;
    vs_TEXCOORD5.w = u_xlat1.z;
    vs_TEXCOORD4.y = u_xlat7.y;
    vs_TEXCOORD5.y = u_xlat7.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FallsFoamSpeed;
uniform 	mediump float _FallsFoamUScale;
uniform 	mediump float _FallsFoamVScale;
uniform 	mediump float _BottomFoamSpeed;
uniform 	mediump float _BottomFoamUScale;
uniform 	mediump float _BottomFoamVScale;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
vec3 u_xlat5;
vec4 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec4 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
vec3 u_xlat14;
mediump float u_xlat16_14;
float u_xlat17;
mediump float u_xlat16_17;
mediump vec3 u_xlat16_20;
float u_xlat26;
mediump float u_xlat16_26;
bool u_xlatb26;
vec2 u_xlat27;
bool u_xlatb30;
float u_xlat32;
bool u_xlatb32;
float u_xlat39;
mediump float u_xlat16_39;
bool u_xlatb39;
float u_xlat40;
bool u_xlatb40;
mediump float u_xlat16_42;
float u_xlat43;
mediump float u_xlat16_43;
int u_xlati43;
uint u_xlatu43;
bool u_xlatb43;
float u_xlat44;
mediump float u_xlat16_44;
bool u_xlatb44;
float u_xlat45;
bool u_xlatb45;
mediump float u_xlat16_46;
mediump float u_xlat16_50;
mediump float u_xlat16_51;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0.xyz = texture(_BumpMap, u_xlat0.xy).xyz;
    u_xlat39 = _Time.y * _FallsFoamSpeed;
    u_xlat1.y = fract(u_xlat39);
    u_xlat1.x = float(0.0);
    u_xlat27.x = float(0.0);
    u_xlat1.xy = vec2(_FallsFoamUScale, _FallsFoamVScale) * vs_TEXCOORD2.zw + u_xlat1.xy;
    u_xlat39 = _Time.y * _BottomFoamSpeed;
    u_xlat27.y = fract(u_xlat39);
    u_xlat27.xy = vec2(_BottomFoamUScale, _BottomFoamVScale) * vs_TEXCOORD2.zw + u_xlat27.xy;
    u_xlat39 = texture(_BumpMap, u_xlat27.xy).z;
    u_xlat1.x = texture(_BumpMap, u_xlat1.xy).w;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_0 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_0);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat4.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat4.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD3.w;
    u_xlat5.y = vs_TEXCOORD4.w;
    u_xlat5.z = vs_TEXCOORD5.w;
    u_xlat14.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat14.xyz, u_xlat14.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat14.xyz;
    u_xlat16_3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat4.xyz;
    u_xlat16_42 = dot((-u_xlat6.xyz), u_xlat16_3.xyz);
    u_xlat16_42 = u_xlat16_42 + u_xlat16_42;
    u_xlat16_7.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_42)) + (-u_xlat6.xyz);
    u_xlat6.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat13 = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat13 = _ZBufferParams.z * u_xlat13 + _ZBufferParams.w;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat4.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat6.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat8.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat9.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat10.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat2.z = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.w = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_42 = u_xlat2.y + u_xlat2.x;
    u_xlat16_46 = u_xlat2.z + u_xlat16_42;
    u_xlat6.x = -0.0;
    u_xlat6.y = (-u_xlat2.x);
    u_xlat6.z = (-u_xlat16_42);
    u_xlat6.w = (-u_xlat16_46);
    u_xlat2 = u_xlat2 + u_xlat6;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_42 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(u_xlat16_42>=0.5);
#else
    u_xlatb43 = u_xlat16_42>=0.5;
#endif
    if(u_xlatb43){
        u_xlat43 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat43 = min(u_xlat43, 3.0);
        u_xlatu43 = uint(u_xlat43);
        u_xlat4.xyz = u_xlat4.xyz + (-unity_ShadowPos[int(u_xlatu43)].xyz);
        u_xlati43 = int(u_xlatu43) << 2;
        u_xlat6.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati43 + 1)].xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati43].xyz * u_xlat4.xxx + u_xlat6.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati43 + 2)].xyz * u_xlat4.zzz + u_xlat6.xyz;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati43 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_4.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_17 = (-_LightShadowData.x) + 1.0;
        u_xlat4.x = u_xlat10_4.x * u_xlat16_17 + _LightShadowData.x;
    } else {
        u_xlat4.x = 1.0;
    //ENDIF
    }
    u_xlat16_42 = u_xlat4.x + -1.0;
    u_xlat16_11.xyz = vec3(_ShadowIntensity) * vec3(u_xlat16_42) + vec3(1.0, 1.0, 1.0);
    u_xlat13 = u_xlat13 + (-vs_TEXCOORD6.w);
    u_xlat10_4.xyz = texture(_RefCube, u_xlat16_7.xyz).xyz;
    u_xlat16_42 = dot(u_xlat10_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz + _RefBackgroundColor.xyz;
    u_xlat16_42 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_46 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_42 = float(1.0) / u_xlat16_42;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_46;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_42 * -2.0 + 3.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_46;
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-_GradualColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz + _GradualColor.xyz;
    u_xlat16_42 = u_xlat13 * u_xlat16_42;
    u_xlat4.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat4.x = u_xlat16_42 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = min(u_xlat13, _DepthFoamExtent);
    u_xlat13 = u_xlat13 / _DepthFoamExtent;
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat16_42 = max(u_xlat13, 9.99999975e-05);
    u_xlat16_42 = log2(u_xlat16_42);
    u_xlat16_42 = u_xlat16_42 * _DepthFoamAtten;
    u_xlat16_42 = exp2(u_xlat16_42);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat1.x>=_FallFoamClip);
#else
    u_xlatb13 = u_xlat1.x>=_FallFoamClip;
#endif
    u_xlat17 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_46 = u_xlat10_0.z * u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_46>=_DepthFoamClip);
#else
    u_xlatb30 = u_xlat16_46>=_DepthFoamClip;
#endif
    u_xlat16_43 = (-_BendFoamWidth) + 0.5;
    u_xlat16_43 = u_xlat16_43 + _BendFoamOffset;
    u_xlat16_44 = _BendFoamWidth + 0.5;
    u_xlat16_44 = u_xlat16_44 + _BendFoamOffset;
    u_xlat16_44 = (-u_xlat16_43) + u_xlat16_44;
    u_xlat43 = (-u_xlat16_43) + vs_TEXCOORD2.y;
    u_xlat16_44 = float(1.0) / u_xlat16_44;
    u_xlat43 = u_xlat43 * u_xlat16_44;
#ifdef UNITY_ADRENO_ES3
    u_xlat43 = min(max(u_xlat43, 0.0), 1.0);
#else
    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
#endif
    u_xlat44 = u_xlat43 * -2.0 + 3.0;
    u_xlat43 = u_xlat43 * u_xlat43;
    u_xlat43 = u_xlat44 * u_xlat43 + -0.5;
    u_xlat43 = -abs(u_xlat43) * 2.0 + 1.0;
    u_xlat16_46 = u_xlat10_0.z * u_xlat43;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat16_46>=_BendFoamClip);
#else
    u_xlatb44 = u_xlat16_46>=_BendFoamClip;
#endif
    u_xlat6.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat32 = u_xlat6.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat10_0.z>=u_xlat32);
#else
    u_xlatb32 = u_xlat10_0.z>=u_xlat32;
#endif
    u_xlat32 = u_xlatb32 ? 1.0 : float(0.0);
    u_xlat32 = u_xlat32 * _SplashFoamColor.w;
    u_xlat45 = u_xlat6.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat39>=u_xlat45);
#else
    u_xlatb45 = u_xlat39>=u_xlat45;
#endif
    u_xlat45 = u_xlatb45 ? 1.0 : float(0.0);
    u_xlat45 = u_xlat45 * _BottomFoamColor.w;
    u_xlat16_46 = u_xlat1.x + (-_FallFoamClip);
    u_xlat16_50 = float(1.0) / _FoamSoften;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_50;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
    u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_46 * -2.0 + 3.0;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_12.x;
    u_xlat1.x = u_xlat17 * u_xlat16_46;
    u_xlat16_46 = (u_xlatb13) ? u_xlat1.x : 0.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_42 = u_xlat16_50 * u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_42 * -2.0 + 3.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_42 * _DepthFoamColor.w;
    u_xlat16_42 = (u_xlatb30) ? u_xlat13 : 0.0;
    u_xlat16_12.x = u_xlat43 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_50 = min(max(u_xlat16_50, 0.0), 1.0);
#else
    u_xlat16_50 = clamp(u_xlat16_50, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_50 * -2.0 + 3.0;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_50;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_50 * _BendFoamColor.w;
    u_xlat16_50 = (u_xlatb44) ? u_xlat13 : 0.0;
    u_xlat13 = (-u_xlat6.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_26 = float(1.0) / _FoamSoften;
    u_xlat13 = u_xlat16_26 * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat1.x;
    u_xlat1.x = u_xlat13 * u_xlat32;
    u_xlat39 = (-u_xlat6.y) * _BottomFoamClip + u_xlat39;
    u_xlat26 = u_xlat16_26 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat26 * -2.0 + 3.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = u_xlat26 * u_xlat39;
    u_xlat39 = u_xlat26 * u_xlat45;
    u_xlat16_12.xyz = (-u_xlat16_7.xyz) + _FallFoamColor.xyz;
    u_xlat16_51 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_46) * u_xlat16_12.xyz + u_xlat16_7.xyz;
    u_xlat16_2.w = u_xlat16_46 * u_xlat16_51 + vs_COLOR0.x;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _DepthFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat16_42) * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _BendFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat16_50) * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _SplashFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = u_xlat1.xxxx * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _BottomFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat39) * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8 = u_xlat16_2 * _MainColor;
    u_xlat16_7.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaRange;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaIntensity;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_42 = u_xlat16_42 + u_xlat16_46;
    u_xlat16_42 = u_xlat16_50 + u_xlat16_42;
    u_xlat16_42 = u_xlat32 * u_xlat13 + u_xlat16_42;
    u_xlat16_42 = u_xlat45 * u_xlat26 + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_42>=9.99999975e-05);
#else
    u_xlatb13 = u_xlat16_42>=9.99999975e-05;
#endif
    u_xlat16_42 = (u_xlatb13) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_20.xyz = (bool(u_xlatb13)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : vec3(0.100000001, 0.100000001, 0.100000001);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_8.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_20.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb26){
        u_xlat16_4.xyz = (-vec3(u_xlat16_42)) + vec3(1.0, 1.0, 1.0);
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_11.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat4.xyz = (-u_xlat5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat26 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat4.xyz;
    u_xlat16_20.x = dot(u_xlat16_3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyw = u_xlat16_20.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_11.xyw * u_xlat16_11.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_11.xyw = u_xlat14.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat16_20.x = dot(u_xlat16_11.xyw, u_xlat16_11.xyw);
    u_xlat16_20.x = inversesqrt(u_xlat16_20.x);
    u_xlat16_11.xyw = u_xlat16_20.xxx * u_xlat16_11.xyw;
    u_xlat16_0 = dot(u_xlat16_3.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat26 = dot(u_xlat4.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_39 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_1 = u_xlat16_39 * u_xlat16_39;
    u_xlat16_14 = u_xlat16_0 * u_xlat16_1 + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_14 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_1 / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_39 = (-u_xlat16_39) * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 + u_xlat16_39;
    u_xlat13 = (u_xlatb13) ? 0.959999979 : 0.899999976;
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat26;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat13 = u_xlat13 * u_xlat16_3.x;
    u_xlat13 = u_xlat13 * u_xlat16_39 + u_xlat16_20.z;
    u_xlat26 = u_xlat13 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat13 + 2.0;
    u_xlat0.x = u_xlat26 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_11.zzz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(_ApplyEnvironmet) * u_xlat16_3.xyz + u_xlat16_8.xyz;
    u_xlat0.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat26 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat14.x * u_xlat1.x;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!((-u_xlat39)>=u_xlat14.x);
#else
    u_xlatb39 = (-u_xlat39)>=u_xlat14.x;
#endif
    u_xlat14.x = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat39 = (u_xlatb39) ? u_xlat14.x : u_xlat1.x;
    u_xlat39 = log2(u_xlat39);
    u_xlat39 = u_xlat39 * unity_FogColor.w;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = min(u_xlat39, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_42 = (-u_xlat1.x) + 2.0;
    u_xlat16_42 = u_xlat1.x * u_xlat16_42;
    u_xlat1.xyz = vec3(u_xlat16_42) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat40 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat40 = u_xlat40 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat40 = min(max(u_xlat40, 0.0), 1.0);
#else
    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat40 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat40));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat40);
#endif
    u_xlat17 = u_xlat40 * -1.44269502;
    u_xlat17 = exp2(u_xlat17);
    u_xlat17 = (-u_xlat17) + 1.0;
    u_xlat40 = u_xlat17 / u_xlat40;
    u_xlat16_42 = (u_xlatb4) ? u_xlat40 : 1.0;
    u_xlat13 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb40 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat4.x = u_xlat13 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat13 = u_xlat4.x / u_xlat13;
    u_xlat16_20.x = (u_xlatb40) ? u_xlat13 : 1.0;
    u_xlat13 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_42 = u_xlat26 * u_xlat16_42;
    u_xlat16_20.x = u_xlat13 * u_xlat16_20.x;
    u_xlat16_42 = exp2((-u_xlat16_42));
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = max(u_xlat16_42, 0.0);
    u_xlat16_20.x = exp2((-u_xlat16_20.x));
    u_xlat16_20.x = (-u_xlat16_20.x) + 1.0;
    u_xlat16_20.x = max(u_xlat16_20.x, 0.0);
    u_xlat16_42 = u_xlat16_42 + u_xlat16_20.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_20.x = (-u_xlat0.x) + 2.0;
    u_xlat16_20.x = u_xlat0.x * u_xlat16_20.x;
    u_xlat0.x = u_xlat16_20.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_42 = u_xlat0.x * u_xlat16_42;
    u_xlat0.x = min(u_xlat16_42, _HeigtFogColBase.w);
    u_xlat13 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat13) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat39) * u_xlat1.xyz;
    u_xlat13 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat39) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
vec2 u_xlat21;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11.x = u_xlat3 * -1.44269502;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat11.x = u_xlat11.x / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11.x : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11.x = (-u_xlat3) + 1.0;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat19);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat19;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat11.xxx * u_xlat10.xyz;
    u_xlat26 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat11.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat21.x = sqrt(u_xlat26);
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat21.y = sqrt(u_xlat26);
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD3.x = u_xlat5.z;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat6.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat6.xyz = u_xlat0.xxx * u_xlat6.xyz;
    vs_TEXCOORD3.y = u_xlat6.x;
    vs_TEXCOORD3.w = u_xlat8.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat8.y;
    vs_TEXCOORD5.w = u_xlat8.z;
    vs_TEXCOORD4.y = u_xlat6.y;
    vs_TEXCOORD5.y = u_xlat6.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FallsFoamSpeed;
uniform 	mediump float _FallsFoamUScale;
uniform 	mediump float _FallsFoamVScale;
uniform 	mediump float _BottomFoamSpeed;
uniform 	mediump float _BottomFoamUScale;
uniform 	mediump float _BottomFoamVScale;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
vec3 u_xlat5;
vec4 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec4 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
vec3 u_xlat14;
mediump float u_xlat16_14;
float u_xlat17;
mediump float u_xlat16_17;
mediump vec3 u_xlat16_20;
float u_xlat26;
mediump float u_xlat16_26;
bool u_xlatb26;
vec2 u_xlat27;
bool u_xlatb30;
float u_xlat32;
bool u_xlatb32;
float u_xlat39;
mediump float u_xlat16_39;
bool u_xlatb39;
float u_xlat40;
bool u_xlatb40;
mediump float u_xlat16_42;
float u_xlat43;
mediump float u_xlat16_43;
int u_xlati43;
uint u_xlatu43;
bool u_xlatb43;
float u_xlat44;
mediump float u_xlat16_44;
bool u_xlatb44;
float u_xlat45;
bool u_xlatb45;
mediump float u_xlat16_46;
mediump float u_xlat16_50;
mediump float u_xlat16_51;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0.xyz = texture(_BumpMap, u_xlat0.xy).xyz;
    u_xlat39 = _Time.y * _FallsFoamSpeed;
    u_xlat1.y = fract(u_xlat39);
    u_xlat1.x = float(0.0);
    u_xlat27.x = float(0.0);
    u_xlat1.xy = vec2(_FallsFoamUScale, _FallsFoamVScale) * vs_TEXCOORD2.zw + u_xlat1.xy;
    u_xlat39 = _Time.y * _BottomFoamSpeed;
    u_xlat27.y = fract(u_xlat39);
    u_xlat27.xy = vec2(_BottomFoamUScale, _BottomFoamVScale) * vs_TEXCOORD2.zw + u_xlat27.xy;
    u_xlat39 = texture(_BumpMap, u_xlat27.xy).z;
    u_xlat1.x = texture(_BumpMap, u_xlat1.xy).w;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_3.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_0 = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat2.z = sqrt(u_xlat16_0);
    u_xlat2.xy = u_xlat16_2.xy;
    u_xlat4.x = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
    u_xlat4.y = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
    u_xlat4.z = dot(vs_TEXCOORD5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD3.w;
    u_xlat5.y = vs_TEXCOORD4.w;
    u_xlat5.z = vs_TEXCOORD5.w;
    u_xlat14.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat14.xyz, u_xlat14.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat14.xyz;
    u_xlat16_3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat4.xyz;
    u_xlat16_42 = dot((-u_xlat6.xyz), u_xlat16_3.xyz);
    u_xlat16_42 = u_xlat16_42 + u_xlat16_42;
    u_xlat16_7.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_42)) + (-u_xlat6.xyz);
    u_xlat6.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat13 = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat13 = _ZBufferParams.z * u_xlat13 + _ZBufferParams.w;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat4.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat6.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat8.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat9.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat10.xyz = u_xlat4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat2.z = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.w = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_42 = u_xlat2.y + u_xlat2.x;
    u_xlat16_46 = u_xlat2.z + u_xlat16_42;
    u_xlat6.x = -0.0;
    u_xlat6.y = (-u_xlat2.x);
    u_xlat6.z = (-u_xlat16_42);
    u_xlat6.w = (-u_xlat16_46);
    u_xlat2 = u_xlat2 + u_xlat6;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_42 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(u_xlat16_42>=0.5);
#else
    u_xlatb43 = u_xlat16_42>=0.5;
#endif
    if(u_xlatb43){
        u_xlat43 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat43 = min(u_xlat43, 3.0);
        u_xlatu43 = uint(u_xlat43);
        u_xlat4.xyz = u_xlat4.xyz + (-unity_ShadowPos[int(u_xlatu43)].xyz);
        u_xlati43 = int(u_xlatu43) << 2;
        u_xlat6.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati43 + 1)].xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati43].xyz * u_xlat4.xxx + u_xlat6.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati43 + 2)].xyz * u_xlat4.zzz + u_xlat6.xyz;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati43 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_4.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_17 = (-_LightShadowData.x) + 1.0;
        u_xlat4.x = u_xlat10_4.x * u_xlat16_17 + _LightShadowData.x;
    } else {
        u_xlat4.x = 1.0;
    //ENDIF
    }
    u_xlat16_42 = u_xlat4.x + -1.0;
    u_xlat16_11.xyz = vec3(_ShadowIntensity) * vec3(u_xlat16_42) + vec3(1.0, 1.0, 1.0);
    u_xlat13 = u_xlat13 + (-vs_TEXCOORD6.w);
    u_xlat10_4.xyz = texture(_RefCube, u_xlat16_7.xyz).xyz;
    u_xlat16_42 = dot(u_xlat10_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz + _RefBackgroundColor.xyz;
    u_xlat16_42 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_46 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_42 = float(1.0) / u_xlat16_42;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_46;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_42 * -2.0 + 3.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_46;
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-_GradualColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz + _GradualColor.xyz;
    u_xlat16_42 = u_xlat13 * u_xlat16_42;
    u_xlat4.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat4.x = u_xlat16_42 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = min(u_xlat13, _DepthFoamExtent);
    u_xlat13 = u_xlat13 / _DepthFoamExtent;
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat16_42 = max(u_xlat13, 9.99999975e-05);
    u_xlat16_42 = log2(u_xlat16_42);
    u_xlat16_42 = u_xlat16_42 * _DepthFoamAtten;
    u_xlat16_42 = exp2(u_xlat16_42);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat1.x>=_FallFoamClip);
#else
    u_xlatb13 = u_xlat1.x>=_FallFoamClip;
#endif
    u_xlat17 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_46 = u_xlat10_0.z * u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_46>=_DepthFoamClip);
#else
    u_xlatb30 = u_xlat16_46>=_DepthFoamClip;
#endif
    u_xlat16_43 = (-_BendFoamWidth) + 0.5;
    u_xlat16_43 = u_xlat16_43 + _BendFoamOffset;
    u_xlat16_44 = _BendFoamWidth + 0.5;
    u_xlat16_44 = u_xlat16_44 + _BendFoamOffset;
    u_xlat16_44 = (-u_xlat16_43) + u_xlat16_44;
    u_xlat43 = (-u_xlat16_43) + vs_TEXCOORD2.y;
    u_xlat16_44 = float(1.0) / u_xlat16_44;
    u_xlat43 = u_xlat43 * u_xlat16_44;
#ifdef UNITY_ADRENO_ES3
    u_xlat43 = min(max(u_xlat43, 0.0), 1.0);
#else
    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
#endif
    u_xlat44 = u_xlat43 * -2.0 + 3.0;
    u_xlat43 = u_xlat43 * u_xlat43;
    u_xlat43 = u_xlat44 * u_xlat43 + -0.5;
    u_xlat43 = -abs(u_xlat43) * 2.0 + 1.0;
    u_xlat16_46 = u_xlat10_0.z * u_xlat43;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat16_46>=_BendFoamClip);
#else
    u_xlatb44 = u_xlat16_46>=_BendFoamClip;
#endif
    u_xlat6.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat32 = u_xlat6.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat10_0.z>=u_xlat32);
#else
    u_xlatb32 = u_xlat10_0.z>=u_xlat32;
#endif
    u_xlat32 = u_xlatb32 ? 1.0 : float(0.0);
    u_xlat32 = u_xlat32 * _SplashFoamColor.w;
    u_xlat45 = u_xlat6.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb45 = !!(u_xlat39>=u_xlat45);
#else
    u_xlatb45 = u_xlat39>=u_xlat45;
#endif
    u_xlat45 = u_xlatb45 ? 1.0 : float(0.0);
    u_xlat45 = u_xlat45 * _BottomFoamColor.w;
    u_xlat16_46 = u_xlat1.x + (-_FallFoamClip);
    u_xlat16_50 = float(1.0) / _FoamSoften;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_50;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
    u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_46 * -2.0 + 3.0;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_12.x;
    u_xlat1.x = u_xlat17 * u_xlat16_46;
    u_xlat16_46 = (u_xlatb13) ? u_xlat1.x : 0.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_42 = u_xlat16_50 * u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_42 * -2.0 + 3.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_42 * _DepthFoamColor.w;
    u_xlat16_42 = (u_xlatb30) ? u_xlat13 : 0.0;
    u_xlat16_12.x = u_xlat43 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_50 = min(max(u_xlat16_50, 0.0), 1.0);
#else
    u_xlat16_50 = clamp(u_xlat16_50, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_50 * -2.0 + 3.0;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_50;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_50 * _BendFoamColor.w;
    u_xlat16_50 = (u_xlatb44) ? u_xlat13 : 0.0;
    u_xlat13 = (-u_xlat6.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_26 = float(1.0) / _FoamSoften;
    u_xlat13 = u_xlat16_26 * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat1.x;
    u_xlat1.x = u_xlat13 * u_xlat32;
    u_xlat39 = (-u_xlat6.y) * _BottomFoamClip + u_xlat39;
    u_xlat26 = u_xlat16_26 * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat26 * -2.0 + 3.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = u_xlat26 * u_xlat39;
    u_xlat39 = u_xlat26 * u_xlat45;
    u_xlat16_12.xyz = (-u_xlat16_7.xyz) + _FallFoamColor.xyz;
    u_xlat16_51 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_46) * u_xlat16_12.xyz + u_xlat16_7.xyz;
    u_xlat16_2.w = u_xlat16_46 * u_xlat16_51 + vs_COLOR0.x;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _DepthFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat16_42) * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _BendFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat16_50) * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _SplashFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = u_xlat1.xxxx * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _BottomFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_2.w) + 1.0;
    u_xlat16_2 = vec4(u_xlat39) * u_xlat16_8 + u_xlat16_2;
    u_xlat16_8 = u_xlat16_2 * _MainColor;
    u_xlat16_7.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaRange;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaIntensity;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_42 = u_xlat16_42 + u_xlat16_46;
    u_xlat16_42 = u_xlat16_50 + u_xlat16_42;
    u_xlat16_42 = u_xlat32 * u_xlat13 + u_xlat16_42;
    u_xlat16_42 = u_xlat45 * u_xlat26 + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_42>=9.99999975e-05);
#else
    u_xlatb13 = u_xlat16_42>=9.99999975e-05;
#endif
    u_xlat16_42 = (u_xlatb13) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_20.xyz = (bool(u_xlatb13)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : vec3(0.100000001, 0.100000001, 0.100000001);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_8.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_20.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb26){
        u_xlat16_4.xyz = (-vec3(u_xlat16_42)) + vec3(1.0, 1.0, 1.0);
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_11.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_4.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat4.xyz = (-u_xlat5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat26 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat4.xyz;
    u_xlat16_20.x = dot(u_xlat16_3.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyw = u_xlat16_20.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_11.xyw * u_xlat16_11.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_11.xyw = u_xlat14.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat16_20.x = dot(u_xlat16_11.xyw, u_xlat16_11.xyw);
    u_xlat16_20.x = inversesqrt(u_xlat16_20.x);
    u_xlat16_11.xyw = u_xlat16_20.xxx * u_xlat16_11.xyw;
    u_xlat16_0 = dot(u_xlat16_3.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat26 = dot(u_xlat4.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_39 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_1 = u_xlat16_39 * u_xlat16_39;
    u_xlat16_14 = u_xlat16_0 * u_xlat16_1 + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_14 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_1 / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_39 = (-u_xlat16_39) * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 + u_xlat16_39;
    u_xlat13 = (u_xlatb13) ? 0.959999979 : 0.899999976;
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat26;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat13 = u_xlat13 * u_xlat16_3.x;
    u_xlat13 = u_xlat13 * u_xlat16_39 + u_xlat16_20.z;
    u_xlat26 = u_xlat13 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat13 + 2.0;
    u_xlat0.x = u_xlat26 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = u_xlat16_11.zzz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(_ApplyEnvironmet) * u_xlat16_3.xyz + u_xlat16_8.xyz;
    u_xlat0.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat26 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat14.x * u_xlat1.x;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!((-u_xlat39)>=u_xlat14.x);
#else
    u_xlatb39 = (-u_xlat39)>=u_xlat14.x;
#endif
    u_xlat14.x = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat39 = (u_xlatb39) ? u_xlat14.x : u_xlat1.x;
    u_xlat39 = log2(u_xlat39);
    u_xlat39 = u_xlat39 * unity_FogColor.w;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = min(u_xlat39, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_42 = (-u_xlat1.x) + 2.0;
    u_xlat16_42 = u_xlat1.x * u_xlat16_42;
    u_xlat1.xyz = vec3(u_xlat16_42) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat40 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat40 = u_xlat40 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat40 = min(max(u_xlat40, 0.0), 1.0);
#else
    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat40 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat40));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat40);
#endif
    u_xlat17 = u_xlat40 * -1.44269502;
    u_xlat17 = exp2(u_xlat17);
    u_xlat17 = (-u_xlat17) + 1.0;
    u_xlat40 = u_xlat17 / u_xlat40;
    u_xlat16_42 = (u_xlatb4) ? u_xlat40 : 1.0;
    u_xlat13 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb40 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat4.x = u_xlat13 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat13 = u_xlat4.x / u_xlat13;
    u_xlat16_20.x = (u_xlatb40) ? u_xlat13 : 1.0;
    u_xlat13 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_42 = u_xlat26 * u_xlat16_42;
    u_xlat16_20.x = u_xlat13 * u_xlat16_20.x;
    u_xlat16_42 = exp2((-u_xlat16_42));
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = max(u_xlat16_42, 0.0);
    u_xlat16_20.x = exp2((-u_xlat16_20.x));
    u_xlat16_20.x = (-u_xlat16_20.x) + 1.0;
    u_xlat16_20.x = max(u_xlat16_20.x, 0.0);
    u_xlat16_42 = u_xlat16_42 + u_xlat16_20.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_20.x = (-u_xlat0.x) + 2.0;
    u_xlat16_20.x = u_xlat0.x * u_xlat16_20.x;
    u_xlat0.x = u_xlat16_20.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_42 = u_xlat0.x * u_xlat16_42;
    u_xlat0.x = min(u_xlat16_42, _HeigtFogColBase.w);
    u_xlat13 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat13) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat39) * u_xlat1.xyz;
    u_xlat13 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat39) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat10;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat18;
vec2 u_xlat21;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat26 = u_xlat25 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.00999999978<abs(u_xlat25));
#else
    u_xlatb25 = 0.00999999978<abs(u_xlat25);
#endif
    u_xlat16_3.x = (u_xlatb25) ? u_xlat26 : 1.0;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat26 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat26 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_11 = (u_xlatb26) ? u_xlat4.x : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_3.y = (-u_xlat16_11) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat26 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat26) + 2.0;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat26 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat26 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat26) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10;
#endif
    u_xlat10 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat18 * u_xlat10;
    u_xlat18 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat18 : u_xlat10;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat10) + 2.0;
    u_xlat16_3.x = u_xlat10 * u_xlat16_3.x;
    u_xlat12.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat12.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat12.xyz;
    u_xlat12.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat25 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat25;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat25) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21.x = sqrt(u_xlat25);
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21.y = sqrt(u_xlat25);
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat7.xyz);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD3.y = u_xlat7.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat5.z;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat1.y;
    vs_TEXCOORD5.w = u_xlat1.z;
    vs_TEXCOORD4.y = u_xlat7.y;
    vs_TEXCOORD5.y = u_xlat7.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec4 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec4 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat17;
mediump vec3 u_xlat16_20;
float u_xlat26;
bool u_xlatb26;
bool u_xlatb29;
float u_xlat32;
bool u_xlatb32;
float u_xlat39;
mediump float u_xlat16_39;
bool u_xlatb39;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_42;
int u_xlati42;
uint u_xlatu42;
bool u_xlatb42;
float u_xlat43;
mediump float u_xlat16_43;
bool u_xlatb43;
float u_xlat44;
bool u_xlatb44;
mediump float u_xlat16_46;
mediump float u_xlat16_50;
mediump float u_xlat16_51;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat0.xy);
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_2.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat1.z = sqrt(u_xlat16_0);
    u_xlat1.xy = u_xlat16_1.xy;
    u_xlat3.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat3.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
    u_xlat3.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat16_41 = dot((-u_xlat6.xyz), u_xlat16_2.xyz);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_41;
    u_xlat16_7.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_41)) + (-u_xlat6.xyz);
    u_xlat6.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat13 = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat13 = _ZBufferParams.z * u_xlat13 + _ZBufferParams.w;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat3.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat6.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat8.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat9.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat10.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.z = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.w = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_41 = u_xlat1.y + u_xlat1.x;
    u_xlat16_46 = u_xlat1.z + u_xlat16_41;
    u_xlat6.x = -0.0;
    u_xlat6.y = (-u_xlat1.x);
    u_xlat6.z = (-u_xlat16_41);
    u_xlat6.w = (-u_xlat16_46);
    u_xlat1 = u_xlat1 + u_xlat6;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_41 = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat16_41>=0.5);
#else
    u_xlatb42 = u_xlat16_41>=0.5;
#endif
    if(u_xlatb42){
        u_xlat42 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat42 = min(u_xlat42, 3.0);
        u_xlatu42 = uint(u_xlat42);
        u_xlat3.xyz = u_xlat3.xyz + (-unity_ShadowPos[int(u_xlatu42)].xyz);
        u_xlati42 = int(u_xlatu42) << 2;
        u_xlat6.xyz = u_xlat3.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 1)].xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati42].xyz * u_xlat3.xxx + u_xlat6.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 2)].xyz * u_xlat3.zzz + u_xlat6.xyz;
        u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
        u_xlat10_3.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat3.x = u_xlat10_3.x * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat3.x = 1.0;
    //ENDIF
    }
    u_xlat16_41 = u_xlat3.x + -1.0;
    u_xlat16_11.xyz = vec3(_ShadowIntensity) * vec3(u_xlat16_41) + vec3(1.0, 1.0, 1.0);
    u_xlat13 = u_xlat13 + (-vs_TEXCOORD6.w);
    u_xlat10_3.xyz = texture(_RefCube, u_xlat16_7.xyz).xyz;
    u_xlat16_41 = dot(u_xlat10_3.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _RefBackgroundColor.xyz;
    u_xlat16_41 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_46 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_41 * -2.0 + 3.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-_GradualColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _GradualColor.xyz;
    u_xlat16_41 = u_xlat13 * u_xlat16_41;
    u_xlat3.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat3.x = u_xlat16_41 * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = min(u_xlat13, _DepthFoamExtent);
    u_xlat13 = u_xlat13 / _DepthFoamExtent;
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat16_41 = max(u_xlat13, 9.99999975e-05);
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * _DepthFoamAtten;
    u_xlat16_41 = exp2(u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb13 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat16 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_46 = u_xlat10_0.z * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(u_xlat16_46>=_DepthFoamClip);
#else
    u_xlatb29 = u_xlat16_46>=_DepthFoamClip;
#endif
    u_xlat16_42 = (-_BendFoamWidth) + 0.5;
    u_xlat16_42 = u_xlat16_42 + _BendFoamOffset;
    u_xlat16_43 = _BendFoamWidth + 0.5;
    u_xlat16_43 = u_xlat16_43 + _BendFoamOffset;
    u_xlat16_43 = (-u_xlat16_42) + u_xlat16_43;
    u_xlat42 = (-u_xlat16_42) + vs_TEXCOORD2.y;
    u_xlat16_43 = float(1.0) / u_xlat16_43;
    u_xlat42 = u_xlat42 * u_xlat16_43;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat43 = u_xlat42 * -2.0 + 3.0;
    u_xlat42 = u_xlat42 * u_xlat42;
    u_xlat42 = u_xlat43 * u_xlat42 + -0.5;
    u_xlat42 = -abs(u_xlat42) * 2.0 + 1.0;
    u_xlat16_46 = u_xlat10_0.z * u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(u_xlat16_46>=_BendFoamClip);
#else
    u_xlatb43 = u_xlat16_46>=_BendFoamClip;
#endif
    u_xlat6.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat44 = u_xlat6.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat10_0.z>=u_xlat44);
#else
    u_xlatb44 = u_xlat10_0.z>=u_xlat44;
#endif
    u_xlat44 = u_xlatb44 ? 1.0 : float(0.0);
    u_xlat44 = u_xlat44 * _SplashFoamColor.w;
    u_xlat32 = u_xlat6.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat10_0.z>=u_xlat32);
#else
    u_xlatb32 = u_xlat10_0.z>=u_xlat32;
#endif
    u_xlat32 = u_xlatb32 ? 1.0 : float(0.0);
    u_xlat32 = u_xlat32 * _BottomFoamColor.w;
    u_xlat16_46 = u_xlat10_0.w + (-_FallFoamClip);
    u_xlat16_50 = float(1.0) / _FoamSoften;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_50;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
    u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_46 * -2.0 + 3.0;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_12.x;
    u_xlat39 = u_xlat16 * u_xlat16_46;
    u_xlat16_46 = (u_xlatb13) ? u_xlat39 : 0.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_41 = u_xlat16_50 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_41 * -2.0 + 3.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_41 * _DepthFoamColor.w;
    u_xlat16_41 = (u_xlatb29) ? u_xlat13 : 0.0;
    u_xlat16_12.x = u_xlat42 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_50 = min(max(u_xlat16_50, 0.0), 1.0);
#else
    u_xlat16_50 = clamp(u_xlat16_50, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_50 * -2.0 + 3.0;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_50;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_50 * _BendFoamColor.w;
    u_xlat16_50 = (u_xlatb43) ? u_xlat13 : 0.0;
    u_xlat13 = (-u_xlat6.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_39 = float(1.0) / _FoamSoften;
    u_xlat13 = u_xlat16_39 * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16 = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat16;
    u_xlat16 = u_xlat13 * u_xlat44;
    u_xlat26 = (-u_xlat6.y) * _BottomFoamClip + u_xlat10_0.z;
    u_xlat26 = u_xlat16_39 * u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat26 * -2.0 + 3.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = u_xlat26 * u_xlat39;
    u_xlat39 = u_xlat26 * u_xlat32;
    u_xlat16_12.xyz = (-u_xlat16_7.xyz) + _FallFoamColor.xyz;
    u_xlat16_51 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_46) * u_xlat16_12.xyz + u_xlat16_7.xyz;
    u_xlat16_1.w = u_xlat16_46 * u_xlat16_51 + vs_COLOR0.x;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _DepthFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_41) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _BendFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_50) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _SplashFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _BottomFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat39) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8 = u_xlat16_1 * _MainColor;
    u_xlat16_7.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaRange;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaIntensity;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 + u_xlat16_46;
    u_xlat16_41 = u_xlat16_50 + u_xlat16_41;
    u_xlat16_41 = u_xlat44 * u_xlat13 + u_xlat16_41;
    u_xlat16_41 = u_xlat32 * u_xlat26 + u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_41>=9.99999975e-05);
#else
    u_xlatb13 = u_xlat16_41>=9.99999975e-05;
#endif
    u_xlat16_41 = (u_xlatb13) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_20.xyz = (bool(u_xlatb13)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : vec3(0.100000001, 0.100000001, 0.100000001);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_8.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_20.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb26){
        u_xlat16_3.xyz = (-vec3(u_xlat16_41)) + vec3(1.0, 1.0, 1.0);
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_11.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat3.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat3.xyz = vec3(u_xlat26) * u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyw = u_xlat16_20.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_11.xyw * u_xlat16_11.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_11.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_11.xyw, u_xlat16_11.xyw);
    u_xlat16_20.x = inversesqrt(u_xlat16_20.x);
    u_xlat16_11.xyw = u_xlat16_20.xxx * u_xlat16_11.xyw;
    u_xlat16_0 = dot(u_xlat16_2.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat26 = dot(u_xlat3.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_39 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_3.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_16 = u_xlat16_0 * u_xlat16_3.x + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_16 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_3.x / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_39 = (-u_xlat16_39) * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 + u_xlat16_39;
    u_xlat13 = (u_xlatb13) ? 0.959999979 : 0.899999976;
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat16_2.x = u_xlat26 * u_xlat26;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_39 + u_xlat16_20.z;
    u_xlat26 = u_xlat13 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat13 + 2.0;
    u_xlat0.x = u_xlat26 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_11.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) * _MainColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_2.xyz + u_xlat16_8.xyz;
    u_xlat0.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat26 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat16 * u_xlat3.x;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!((-u_xlat39)>=u_xlat16);
#else
    u_xlatb39 = (-u_xlat39)>=u_xlat16;
#endif
    u_xlat16 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat39 = (u_xlatb39) ? u_xlat16 : u_xlat3.x;
    u_xlat39 = log2(u_xlat39);
    u_xlat39 = u_xlat39 * unity_FogColor.w;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = min(u_xlat39, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat3.x) + 2.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat16_41) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat42 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat42 = u_xlat42 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat42) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat42 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat42));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat42);
#endif
    u_xlat17 = u_xlat42 * -1.44269502;
    u_xlat17 = exp2(u_xlat17);
    u_xlat17 = (-u_xlat17) + 1.0;
    u_xlat42 = u_xlat17 / u_xlat42;
    u_xlat16_41 = (u_xlatb4) ? u_xlat42 : 1.0;
    u_xlat13 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb42 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat4.x = u_xlat13 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat13 = u_xlat4.x / u_xlat13;
    u_xlat16_20.x = (u_xlatb42) ? u_xlat13 : 1.0;
    u_xlat13 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_41 = u_xlat26 * u_xlat16_41;
    u_xlat16_20.x = u_xlat13 * u_xlat16_20.x;
    u_xlat16_41 = exp2((-u_xlat16_41));
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_20.x = exp2((-u_xlat16_20.x));
    u_xlat16_20.x = (-u_xlat16_20.x) + 1.0;
    u_xlat16_20.x = max(u_xlat16_20.x, 0.0);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_20.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_20.x = (-u_xlat0.x) + 2.0;
    u_xlat16_20.x = u_xlat0.x * u_xlat16_20.x;
    u_xlat0.x = u_xlat16_20.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_41 = u_xlat0.x * u_xlat16_41;
    u_xlat0.x = min(u_xlat16_41, _HeigtFogColBase.w);
    u_xlat13 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat13) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat13 = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat39) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
vec2 u_xlat21;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11.x = u_xlat3 * -1.44269502;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat11.x = u_xlat11.x / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11.x : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11.x = (-u_xlat3) + 1.0;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat19);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat19;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat11.xxx * u_xlat10.xyz;
    u_xlat26 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat11.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat21.x = sqrt(u_xlat26);
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat21.y = sqrt(u_xlat26);
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD3.x = u_xlat5.z;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat6.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat6.xyz = u_xlat0.xxx * u_xlat6.xyz;
    vs_TEXCOORD3.y = u_xlat6.x;
    vs_TEXCOORD3.w = u_xlat8.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat8.y;
    vs_TEXCOORD5.w = u_xlat8.z;
    vs_TEXCOORD4.y = u_xlat6.y;
    vs_TEXCOORD5.y = u_xlat6.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _FoamSoften;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec4 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec4 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
float u_xlat16;
mediump float u_xlat16_16;
float u_xlat17;
mediump vec3 u_xlat16_20;
float u_xlat26;
bool u_xlatb26;
bool u_xlatb29;
float u_xlat32;
bool u_xlatb32;
float u_xlat39;
mediump float u_xlat16_39;
bool u_xlatb39;
mediump float u_xlat16_41;
float u_xlat42;
mediump float u_xlat16_42;
int u_xlati42;
uint u_xlatu42;
bool u_xlatb42;
float u_xlat43;
mediump float u_xlat16_43;
bool u_xlatb43;
float u_xlat44;
bool u_xlatb44;
mediump float u_xlat16_46;
mediump float u_xlat16_50;
mediump float u_xlat16_51;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat0.xy);
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_2.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat1.z = sqrt(u_xlat16_0);
    u_xlat1.xy = u_xlat16_1.xy;
    u_xlat3.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat3.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
    u_xlat3.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat16_41 = dot((-u_xlat6.xyz), u_xlat16_2.xyz);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_41;
    u_xlat16_7.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_41)) + (-u_xlat6.xyz);
    u_xlat6.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat13 = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat13 = _ZBufferParams.z * u_xlat13 + _ZBufferParams.w;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat3.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat6.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat8.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat9.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat10.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.z = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.w = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_41 = u_xlat1.y + u_xlat1.x;
    u_xlat16_46 = u_xlat1.z + u_xlat16_41;
    u_xlat6.x = -0.0;
    u_xlat6.y = (-u_xlat1.x);
    u_xlat6.z = (-u_xlat16_41);
    u_xlat6.w = (-u_xlat16_46);
    u_xlat1 = u_xlat1 + u_xlat6;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_41 = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat16_41>=0.5);
#else
    u_xlatb42 = u_xlat16_41>=0.5;
#endif
    if(u_xlatb42){
        u_xlat42 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat42 = min(u_xlat42, 3.0);
        u_xlatu42 = uint(u_xlat42);
        u_xlat3.xyz = u_xlat3.xyz + (-unity_ShadowPos[int(u_xlatu42)].xyz);
        u_xlati42 = int(u_xlatu42) << 2;
        u_xlat6.xyz = u_xlat3.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 1)].xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati42].xyz * u_xlat3.xxx + u_xlat6.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 2)].xyz * u_xlat3.zzz + u_xlat6.xyz;
        u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
        u_xlat10_3.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat3.x = u_xlat10_3.x * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat3.x = 1.0;
    //ENDIF
    }
    u_xlat16_41 = u_xlat3.x + -1.0;
    u_xlat16_11.xyz = vec3(_ShadowIntensity) * vec3(u_xlat16_41) + vec3(1.0, 1.0, 1.0);
    u_xlat13 = u_xlat13 + (-vs_TEXCOORD6.w);
    u_xlat10_3.xyz = texture(_RefCube, u_xlat16_7.xyz).xyz;
    u_xlat16_41 = dot(u_xlat10_3.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _RefBackgroundColor.xyz;
    u_xlat16_41 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_46 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_41 * -2.0 + 3.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-_GradualColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _GradualColor.xyz;
    u_xlat16_41 = u_xlat13 * u_xlat16_41;
    u_xlat3.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat3.x = u_xlat16_41 * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = min(u_xlat13, _DepthFoamExtent);
    u_xlat13 = u_xlat13 / _DepthFoamExtent;
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat16_41 = max(u_xlat13, 9.99999975e-05);
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * _DepthFoamAtten;
    u_xlat16_41 = exp2(u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb13 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat16 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat16_46 = u_xlat10_0.z * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(u_xlat16_46>=_DepthFoamClip);
#else
    u_xlatb29 = u_xlat16_46>=_DepthFoamClip;
#endif
    u_xlat16_42 = (-_BendFoamWidth) + 0.5;
    u_xlat16_42 = u_xlat16_42 + _BendFoamOffset;
    u_xlat16_43 = _BendFoamWidth + 0.5;
    u_xlat16_43 = u_xlat16_43 + _BendFoamOffset;
    u_xlat16_43 = (-u_xlat16_42) + u_xlat16_43;
    u_xlat42 = (-u_xlat16_42) + vs_TEXCOORD2.y;
    u_xlat16_43 = float(1.0) / u_xlat16_43;
    u_xlat42 = u_xlat42 * u_xlat16_43;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat43 = u_xlat42 * -2.0 + 3.0;
    u_xlat42 = u_xlat42 * u_xlat42;
    u_xlat42 = u_xlat43 * u_xlat42 + -0.5;
    u_xlat42 = -abs(u_xlat42) * 2.0 + 1.0;
    u_xlat16_46 = u_xlat10_0.z * u_xlat42;
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(u_xlat16_46>=_BendFoamClip);
#else
    u_xlatb43 = u_xlat16_46>=_BendFoamClip;
#endif
    u_xlat6.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat44 = u_xlat6.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!(u_xlat10_0.z>=u_xlat44);
#else
    u_xlatb44 = u_xlat10_0.z>=u_xlat44;
#endif
    u_xlat44 = u_xlatb44 ? 1.0 : float(0.0);
    u_xlat44 = u_xlat44 * _SplashFoamColor.w;
    u_xlat32 = u_xlat6.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat10_0.z>=u_xlat32);
#else
    u_xlatb32 = u_xlat10_0.z>=u_xlat32;
#endif
    u_xlat32 = u_xlatb32 ? 1.0 : float(0.0);
    u_xlat32 = u_xlat32 * _BottomFoamColor.w;
    u_xlat16_46 = u_xlat10_0.w + (-_FallFoamClip);
    u_xlat16_50 = float(1.0) / _FoamSoften;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_50;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
    u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_46 * -2.0 + 3.0;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_12.x;
    u_xlat39 = u_xlat16 * u_xlat16_46;
    u_xlat16_46 = (u_xlatb13) ? u_xlat39 : 0.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat10_0.z + (-_DepthFoamClip);
    u_xlat16_41 = u_xlat16_50 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_41 * -2.0 + 3.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_41 * _DepthFoamColor.w;
    u_xlat16_41 = (u_xlatb29) ? u_xlat13 : 0.0;
    u_xlat16_12.x = u_xlat42 * u_xlat10_0.z + (-_BendFoamClip);
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_50 = min(max(u_xlat16_50, 0.0), 1.0);
#else
    u_xlat16_50 = clamp(u_xlat16_50, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_50 * -2.0 + 3.0;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_50;
    u_xlat16_50 = u_xlat16_50 * u_xlat16_12.x;
    u_xlat13 = u_xlat16_50 * _BendFoamColor.w;
    u_xlat16_50 = (u_xlatb43) ? u_xlat13 : 0.0;
    u_xlat13 = (-u_xlat6.x) * _SplashFoamClip + u_xlat10_0.z;
    u_xlat16_39 = float(1.0) / _FoamSoften;
    u_xlat13 = u_xlat16_39 * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat16 = u_xlat13 * -2.0 + 3.0;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat13 = u_xlat13 * u_xlat16;
    u_xlat16 = u_xlat13 * u_xlat44;
    u_xlat26 = (-u_xlat6.y) * _BottomFoamClip + u_xlat10_0.z;
    u_xlat26 = u_xlat16_39 * u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat39 = u_xlat26 * -2.0 + 3.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = u_xlat26 * u_xlat39;
    u_xlat39 = u_xlat26 * u_xlat32;
    u_xlat16_12.xyz = (-u_xlat16_7.xyz) + _FallFoamColor.xyz;
    u_xlat16_51 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat16_46) * u_xlat16_12.xyz + u_xlat16_7.xyz;
    u_xlat16_1.w = u_xlat16_46 * u_xlat16_51 + vs_COLOR0.x;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _DepthFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_41) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _BendFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_50) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _SplashFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + _BottomFoamColor.xyz;
    u_xlat16_8.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat39) * u_xlat16_8 + u_xlat16_1;
    u_xlat16_8 = u_xlat16_1 * _MainColor;
    u_xlat16_7.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaRange;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaIntensity;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 + u_xlat16_46;
    u_xlat16_41 = u_xlat16_50 + u_xlat16_41;
    u_xlat16_41 = u_xlat44 * u_xlat13 + u_xlat16_41;
    u_xlat16_41 = u_xlat32 * u_xlat26 + u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_41>=9.99999975e-05);
#else
    u_xlatb13 = u_xlat16_41>=9.99999975e-05;
#endif
    u_xlat16_41 = (u_xlatb13) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_20.xyz = (bool(u_xlatb13)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : vec3(0.100000001, 0.100000001, 0.100000001);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_8.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_20.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb26){
        u_xlat16_3.xyz = (-vec3(u_xlat16_41)) + vec3(1.0, 1.0, 1.0);
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_11.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat3.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat3.xyz = vec3(u_xlat26) * u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyw = u_xlat16_20.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_11.xyw * u_xlat16_11.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_11.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_11.xyw, u_xlat16_11.xyw);
    u_xlat16_20.x = inversesqrt(u_xlat16_20.x);
    u_xlat16_11.xyw = u_xlat16_20.xxx * u_xlat16_11.xyw;
    u_xlat16_0 = dot(u_xlat16_2.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat26 = dot(u_xlat3.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_39 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_3.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_16 = u_xlat16_0 * u_xlat16_3.x + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_16 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_3.x / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_39 = (-u_xlat16_39) * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 + u_xlat16_39;
    u_xlat13 = (u_xlatb13) ? 0.959999979 : 0.899999976;
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat16_2.x = u_xlat26 * u_xlat26;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_39 + u_xlat16_20.z;
    u_xlat26 = u_xlat13 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat13 + 2.0;
    u_xlat0.x = u_xlat26 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_11.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) * _MainColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_2.xyz + u_xlat16_8.xyz;
    u_xlat0.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat26 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat16 * u_xlat3.x;
    u_xlat16 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!((-u_xlat39)>=u_xlat16);
#else
    u_xlatb39 = (-u_xlat39)>=u_xlat16;
#endif
    u_xlat16 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat39 = (u_xlatb39) ? u_xlat16 : u_xlat3.x;
    u_xlat39 = log2(u_xlat39);
    u_xlat39 = u_xlat39 * unity_FogColor.w;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = min(u_xlat39, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat3.x) + 2.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat16_41) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat42 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat42 = u_xlat42 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat42) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat42 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat42));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat42);
#endif
    u_xlat17 = u_xlat42 * -1.44269502;
    u_xlat17 = exp2(u_xlat17);
    u_xlat17 = (-u_xlat17) + 1.0;
    u_xlat42 = u_xlat17 / u_xlat42;
    u_xlat16_41 = (u_xlatb4) ? u_xlat42 : 1.0;
    u_xlat13 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb42 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat4.x = u_xlat13 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat13 = u_xlat4.x / u_xlat13;
    u_xlat16_20.x = (u_xlatb42) ? u_xlat13 : 1.0;
    u_xlat13 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_41 = u_xlat26 * u_xlat16_41;
    u_xlat16_20.x = u_xlat13 * u_xlat16_20.x;
    u_xlat16_41 = exp2((-u_xlat16_41));
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_20.x = exp2((-u_xlat16_20.x));
    u_xlat16_20.x = (-u_xlat16_20.x) + 1.0;
    u_xlat16_20.x = max(u_xlat16_20.x, 0.0);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_20.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_20.x = (-u_xlat0.x) + 2.0;
    u_xlat16_20.x = u_xlat0.x * u_xlat16_20.x;
    u_xlat0.x = u_xlat16_20.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_41 = u_xlat0.x * u_xlat16_41;
    u_xlat0.x = min(u_xlat16_41, _HeigtFogColBase.w);
    u_xlat13 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat13) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat13 = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat39) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat10;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat18;
vec2 u_xlat21;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat26 = u_xlat25 * -1.44269502;
    u_xlat26 = exp2(u_xlat26);
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat26 = u_xlat26 / u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.00999999978<abs(u_xlat25));
#else
    u_xlatb25 = 0.00999999978<abs(u_xlat25);
#endif
    u_xlat16_3.x = (u_xlatb25) ? u_xlat26 : 1.0;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = sqrt(u_xlat25);
    u_xlat26 = u_xlat25 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat26 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat26 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_11 = (u_xlatb26) ? u_xlat4.x : 1.0;
    u_xlat26 = u_xlat25 * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_3.y = (-u_xlat16_11) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat26 = u_xlat25 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat26) + 2.0;
    u_xlat16_11 = u_xlat26 * u_xlat16_11;
    u_xlat26 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_3.x = u_xlat26 * u_xlat16_3.x;
    u_xlat26 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat26) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10;
#endif
    u_xlat10 = u_xlat25 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + (-_HeigtFogRamp.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat18 * u_xlat10;
    u_xlat18 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat18 : u_xlat10;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat10) + 2.0;
    u_xlat16_3.x = u_xlat10 * u_xlat16_3.x;
    u_xlat12.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat12.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat12.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat12.xyz;
    u_xlat12.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat25 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat25;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat25 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat25) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21.x = sqrt(u_xlat25);
    u_xlat25 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21.y = sqrt(u_xlat25);
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = u_xlat1.x;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat7.xyz);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat7.xyz;
    vs_TEXCOORD3.y = u_xlat7.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat5.z;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat1.y;
    vs_TEXCOORD5.w = u_xlat1.z;
    vs_TEXCOORD4.y = u_xlat7.y;
    vs_TEXCOORD5.y = u_xlat7.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
vec2 u_xlat16;
mediump float u_xlat16_16;
float u_xlat17;
mediump vec3 u_xlat16_20;
float u_xlat26;
bool u_xlatb26;
float u_xlat29;
float u_xlat39;
mediump float u_xlat16_39;
bool u_xlatb39;
mediump float u_xlat16_41;
float u_xlat42;
int u_xlati42;
uint u_xlatu42;
bool u_xlatb42;
mediump float u_xlat16_46;
mediump float u_xlat16_50;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat0.xy);
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_2.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat1.z = sqrt(u_xlat16_0);
    u_xlat1.xy = u_xlat16_1.xy;
    u_xlat3.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat3.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
    u_xlat3.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat16_41 = dot((-u_xlat6.xyz), u_xlat16_2.xyz);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_41;
    u_xlat16_7.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_41)) + (-u_xlat6.xyz);
    u_xlat6.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat13 = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat13 = _ZBufferParams.z * u_xlat13 + _ZBufferParams.w;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat3.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat6.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat8.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat9.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat10.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.z = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.w = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_41 = u_xlat1.y + u_xlat1.x;
    u_xlat16_46 = u_xlat1.z + u_xlat16_41;
    u_xlat6.x = -0.0;
    u_xlat6.y = (-u_xlat1.x);
    u_xlat6.z = (-u_xlat16_41);
    u_xlat6.w = (-u_xlat16_46);
    u_xlat1 = u_xlat1 + u_xlat6;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_41 = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat16_41>=0.5);
#else
    u_xlatb42 = u_xlat16_41>=0.5;
#endif
    if(u_xlatb42){
        u_xlat42 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat42 = min(u_xlat42, 3.0);
        u_xlatu42 = uint(u_xlat42);
        u_xlat3.xyz = u_xlat3.xyz + (-unity_ShadowPos[int(u_xlatu42)].xyz);
        u_xlati42 = int(u_xlatu42) << 2;
        u_xlat6.xyz = u_xlat3.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 1)].xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati42].xyz * u_xlat3.xxx + u_xlat6.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 2)].xyz * u_xlat3.zzz + u_xlat6.xyz;
        u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
        u_xlat10_3.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat3.x = u_xlat10_3.x * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat3.x = 1.0;
    //ENDIF
    }
    u_xlat16_41 = u_xlat3.x + -1.0;
    u_xlat16_11.xyz = vec3(_ShadowIntensity) * vec3(u_xlat16_41) + vec3(1.0, 1.0, 1.0);
    u_xlat13 = u_xlat13 + (-vs_TEXCOORD6.w);
    u_xlat10_3.xyz = texture(_RefCube, u_xlat16_7.xyz).xyz;
    u_xlat16_41 = dot(u_xlat10_3.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _RefBackgroundColor.xyz;
    u_xlat16_41 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_46 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_41 * -2.0 + 3.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-_GradualColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _GradualColor.xyz;
    u_xlat16_41 = u_xlat13 * u_xlat16_41;
    u_xlat3.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat3.x = u_xlat16_41 * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = min(u_xlat13, _DepthFoamExtent);
    u_xlat13 = u_xlat13 / _DepthFoamExtent;
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat16_41 = max(u_xlat13, 9.99999975e-05);
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * _DepthFoamAtten;
    u_xlat16_41 = exp2(u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb13 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat39 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat13 = u_xlatb13 ? u_xlat39 : float(0.0);
    u_xlat16_41 = u_xlat10_0.z * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(u_xlat16_41>=_DepthFoamClip);
#else
    u_xlatb39 = u_xlat16_41>=_DepthFoamClip;
#endif
    u_xlat16_41 = (u_xlatb39) ? _DepthFoamColor.w : 0.0;
    u_xlat16_39 = (-_BendFoamWidth) + 0.5;
    u_xlat16_39 = u_xlat16_39 + _BendFoamOffset;
    u_xlat16_16 = _BendFoamWidth + 0.5;
    u_xlat16_16 = u_xlat16_16 + _BendFoamOffset;
    u_xlat16_16 = (-u_xlat16_39) + u_xlat16_16;
    u_xlat39 = (-u_xlat16_39) + vs_TEXCOORD2.y;
    u_xlat16_16 = float(1.0) / u_xlat16_16;
    u_xlat39 = u_xlat39 * u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat16.x = u_xlat39 * -2.0 + 3.0;
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat39 = u_xlat16.x * u_xlat39 + -0.5;
    u_xlat39 = -abs(u_xlat39) * 2.0 + 1.0;
    u_xlat16_46 = u_xlat10_0.z * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(u_xlat16_46>=_BendFoamClip);
#else
    u_xlatb39 = u_xlat16_46>=_BendFoamClip;
#endif
    u_xlat16_46 = (u_xlatb39) ? _BendFoamColor.w : 0.0;
    u_xlat16.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat39 = u_xlat16.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(u_xlat10_0.z>=u_xlat39);
#else
    u_xlatb39 = u_xlat10_0.z>=u_xlat39;
#endif
    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat39 * _SplashFoamColor.w;
    u_xlat29 = u_xlat16.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat10_0.z>=u_xlat29);
#else
    u_xlatb26 = u_xlat10_0.z>=u_xlat29;
#endif
    u_xlat26 = u_xlatb26 ? 1.0 : float(0.0);
    u_xlat29 = u_xlat26 * _BottomFoamColor.w;
    u_xlat16_12.xyz = (-u_xlat16_7.xyz) + _FallFoamColor.xyz;
    u_xlat16_50 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat13) * u_xlat16_12.xyz + u_xlat16_7.xyz;
    u_xlat16_1.w = u_xlat13 * u_xlat16_50 + vs_COLOR0.x;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _DepthFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_41) * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _BendFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_46) * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _SplashFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = u_xlat16.xxxx * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _BottomFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat29) * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6 = u_xlat16_1 * _MainColor;
    u_xlat16_7.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaRange;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaIntensity;
    u_xlat16_7.x = u_xlat16_6.w * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat13 + u_xlat16_41;
    u_xlat16_41 = u_xlat16_46 + u_xlat16_41;
    u_xlat16_41 = u_xlat39 * _SplashFoamColor.w + u_xlat16_41;
    u_xlat16_41 = u_xlat26 * _BottomFoamColor.w + u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_41>=9.99999975e-05);
#else
    u_xlatb13 = u_xlat16_41>=9.99999975e-05;
#endif
    u_xlat16_41 = (u_xlatb13) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_20.xyz = (bool(u_xlatb13)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : vec3(0.100000001, 0.100000001, 0.100000001);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_20.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb26){
        u_xlat16_3.xyz = (-vec3(u_xlat16_41)) + vec3(1.0, 1.0, 1.0);
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_11.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat3.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat3.xyz = vec3(u_xlat26) * u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyw = u_xlat16_20.xxx * _LightColor0.xyz;
    u_xlat8.xyz = u_xlat16_11.xyw * u_xlat16_11.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_11.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_11.xyw, u_xlat16_11.xyw);
    u_xlat16_20.x = inversesqrt(u_xlat16_20.x);
    u_xlat16_11.xyw = u_xlat16_20.xxx * u_xlat16_11.xyw;
    u_xlat16_0 = dot(u_xlat16_2.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat26 = dot(u_xlat3.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_39 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_3.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_16 = u_xlat16_0 * u_xlat16_3.x + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_16 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_3.x / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_39 = (-u_xlat16_39) * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 + u_xlat16_39;
    u_xlat13 = (u_xlatb13) ? 0.959999979 : 0.899999976;
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat16_2.x = u_xlat26 * u_xlat26;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_39 + u_xlat16_20.z;
    u_xlat26 = u_xlat13 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat13 + 2.0;
    u_xlat0.x = u_xlat26 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_11.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat8.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) * _MainColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat26 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat16.x * u_xlat3.x;
    u_xlat16.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!((-u_xlat39)>=u_xlat16.x);
#else
    u_xlatb39 = (-u_xlat39)>=u_xlat16.x;
#endif
    u_xlat16.x = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat39 = (u_xlatb39) ? u_xlat16.x : u_xlat3.x;
    u_xlat39 = log2(u_xlat39);
    u_xlat39 = u_xlat39 * unity_FogColor.w;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = min(u_xlat39, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat3.x) + 2.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat16_41) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat42 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat42 = u_xlat42 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat42) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat42 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat42));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat42);
#endif
    u_xlat17 = u_xlat42 * -1.44269502;
    u_xlat17 = exp2(u_xlat17);
    u_xlat17 = (-u_xlat17) + 1.0;
    u_xlat42 = u_xlat17 / u_xlat42;
    u_xlat16_41 = (u_xlatb4) ? u_xlat42 : 1.0;
    u_xlat13 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb42 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat4.x = u_xlat13 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat13 = u_xlat4.x / u_xlat13;
    u_xlat16_20.x = (u_xlatb42) ? u_xlat13 : 1.0;
    u_xlat13 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_41 = u_xlat26 * u_xlat16_41;
    u_xlat16_20.x = u_xlat13 * u_xlat16_20.x;
    u_xlat16_41 = exp2((-u_xlat16_41));
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_20.x = exp2((-u_xlat16_20.x));
    u_xlat16_20.x = (-u_xlat16_20.x) + 1.0;
    u_xlat16_20.x = max(u_xlat16_20.x, 0.0);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_20.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_20.x = (-u_xlat0.x) + 2.0;
    u_xlat16_20.x = u_xlat0.x * u_xlat16_20.x;
    u_xlat0.x = u_xlat16_20.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_41 = u_xlat0.x * u_xlat16_41;
    u_xlat0.x = min(u_xlat16_41, _HeigtFogColBase.w);
    u_xlat13 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat13) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat13 = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat39) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" }
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
uniform 	mediump vec4 _BumpMap_ST;
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
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
float u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat10;
vec3 u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat19;
vec2 u_xlat21;
float u_xlat26;
bool u_xlatb26;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat8.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat8.xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11.x = u_xlat3 * -1.44269502;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat11.x = (-u_xlat11.x) + 1.0;
    u_xlat11.x = u_xlat11.x / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11.x : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11.x = (-u_xlat3) + 1.0;
    u_xlat19 = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat19);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat19;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11.x * u_xlat2.x;
    u_xlat2.xyz = u_xlat11.xxx * u_xlat10.xyz;
    u_xlat26 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat11.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat5.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat21.x = sqrt(u_xlat26);
    u_xlat26 = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat21.y = sqrt(u_xlat26);
    vs_TEXCOORD2.zw = u_xlat21.xy * u_xlat5.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD3.x = u_xlat5.z;
    u_xlat6.xyz = u_xlat2.zxy * u_xlat5.xyz;
    u_xlat6.xyz = u_xlat2.yzx * u_xlat5.yzx + (-u_xlat6.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat6.xyz = u_xlat0.xxx * u_xlat6.xyz;
    vs_TEXCOORD3.y = u_xlat6.x;
    vs_TEXCOORD3.w = u_xlat8.x;
    vs_TEXCOORD3.z = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat5.x;
    vs_TEXCOORD5.x = u_xlat5.y;
    vs_TEXCOORD4.z = u_xlat2.y;
    vs_TEXCOORD5.z = u_xlat2.z;
    vs_TEXCOORD4.w = u_xlat8.y;
    vs_TEXCOORD5.w = u_xlat8.z;
    vs_TEXCOORD4.y = u_xlat6.y;
    vs_TEXCOORD5.y = u_xlat6.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FoamRoughnes;
uniform 	mediump float _Speed;
uniform 	mediump float _NormalScale;
uniform 	mediump vec4 _RefForegroundColor;
uniform 	mediump vec4 _RefBackgroundColor;
uniform 	mediump vec3 _GradualColor;
uniform 	mediump float _ColorLerpRangeStart;
uniform 	mediump float _ColorLerpRangeEnd;
uniform 	mediump vec4 _BendFoamColor;
uniform 	mediump float _BendFoamClip;
uniform 	mediump float _BendFoamWidth;
uniform 	mediump float _BendFoamOffset;
uniform 	mediump vec4 _SplashFoamColor;
uniform 	mediump float _SplashFoamClip;
uniform 	mediump vec4 _BottomFoamColor;
uniform 	mediump float _BottomFoamClip;
uniform 	mediump vec4 _DepthFoamColor;
uniform 	mediump float _DepthFoamExtent;
uniform 	mediump float _DepthFoamAtten;
uniform 	mediump float _DepthFoamClip;
uniform 	mediump vec4 _FallFoamColor;
uniform 	mediump float _FallFoamClip;
uniform 	mediump float _AlphaRange;
uniform 	mediump float _AlphaIntensity;
uniform 	mediump float _ShadowBump;
uniform 	mediump float _ShadowIntensity;
uniform 	mediump float _ApplyEnvironmet;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp samplerCube _RefCube;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec4 u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat13;
bool u_xlatb13;
vec2 u_xlat16;
mediump float u_xlat16_16;
float u_xlat17;
mediump vec3 u_xlat16_20;
float u_xlat26;
bool u_xlatb26;
float u_xlat29;
float u_xlat39;
mediump float u_xlat16_39;
bool u_xlatb39;
mediump float u_xlat16_41;
float u_xlat42;
int u_xlati42;
uint u_xlatu42;
bool u_xlatb42;
mediump float u_xlat16_46;
mediump float u_xlat16_50;
void main()
{
    u_xlat0.x = _Time.y * _Speed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = u_xlat0.x + vs_TEXCOORD2.w;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat10_0 = texture(_BumpMap, u_xlat0.xy);
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat16_2.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_0 = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 0.0);
    u_xlat16_0 = u_xlat16_0 + 9.99999975e-05;
    u_xlat1.z = sqrt(u_xlat16_0);
    u_xlat1.xy = u_xlat16_1.xy;
    u_xlat3.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
    u_xlat3.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
    u_xlat3.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD3.w;
    u_xlat4.y = vs_TEXCOORD4.w;
    u_xlat4.z = vs_TEXCOORD5.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat16_41 = dot((-u_xlat6.xyz), u_xlat16_2.xyz);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_41;
    u_xlat16_7.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_41)) + (-u_xlat6.xyz);
    u_xlat6.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat13 = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat13 = _ZBufferParams.z * u_xlat13 + _ZBufferParams.w;
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat3.xyz = vec3(vec3(_ShadowBump, _ShadowBump, _ShadowBump)) * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat6.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat8.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat9.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat10.xyz = u_xlat3.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.z = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.w = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_41 = u_xlat1.y + u_xlat1.x;
    u_xlat16_46 = u_xlat1.z + u_xlat16_41;
    u_xlat6.x = -0.0;
    u_xlat6.y = (-u_xlat1.x);
    u_xlat6.z = (-u_xlat16_41);
    u_xlat6.w = (-u_xlat16_46);
    u_xlat1 = u_xlat1 + u_xlat6;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_41 = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(u_xlat16_41>=0.5);
#else
    u_xlatb42 = u_xlat16_41>=0.5;
#endif
    if(u_xlatb42){
        u_xlat42 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat42 = min(u_xlat42, 3.0);
        u_xlatu42 = uint(u_xlat42);
        u_xlat3.xyz = u_xlat3.xyz + (-unity_ShadowPos[int(u_xlatu42)].xyz);
        u_xlati42 = int(u_xlatu42) << 2;
        u_xlat6.xyz = u_xlat3.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 1)].xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati42].xyz * u_xlat3.xxx + u_xlat6.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 2)].xyz * u_xlat3.zzz + u_xlat6.xyz;
        u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati42 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
        u_xlat10_3.x = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_16 = (-_LightShadowData.x) + 1.0;
        u_xlat3.x = u_xlat10_3.x * u_xlat16_16 + _LightShadowData.x;
    } else {
        u_xlat3.x = 1.0;
    //ENDIF
    }
    u_xlat16_41 = u_xlat3.x + -1.0;
    u_xlat16_11.xyz = vec3(_ShadowIntensity) * vec3(u_xlat16_41) + vec3(1.0, 1.0, 1.0);
    u_xlat13 = u_xlat13 + (-vs_TEXCOORD6.w);
    u_xlat10_3.xyz = texture(_RefCube, u_xlat16_7.xyz).xyz;
    u_xlat16_41 = dot(u_xlat10_3.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = _RefForegroundColor.xyz + (-_RefBackgroundColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _RefBackgroundColor.xyz;
    u_xlat16_41 = (-_ColorLerpRangeStart) + _ColorLerpRangeEnd;
    u_xlat16_46 = vs_TEXCOORD2.y + (-_ColorLerpRangeStart);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_46 = u_xlat16_41 * -2.0 + 3.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-_GradualColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_41) * u_xlat16_7.xyz + _GradualColor.xyz;
    u_xlat16_41 = u_xlat13 * u_xlat16_41;
    u_xlat3.x = (-vs_TEXCOORD2.y) + 1.0;
    u_xlat3.x = u_xlat16_41 * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = min(u_xlat13, _DepthFoamExtent);
    u_xlat13 = u_xlat13 / _DepthFoamExtent;
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat16_41 = max(u_xlat13, 9.99999975e-05);
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_41 = u_xlat16_41 * _DepthFoamAtten;
    u_xlat16_41 = exp2(u_xlat16_41);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat10_0.w>=_FallFoamClip);
#else
    u_xlatb13 = u_xlat10_0.w>=_FallFoamClip;
#endif
    u_xlat39 = vs_COLOR0.y * _FallFoamColor.w;
    u_xlat13 = u_xlatb13 ? u_xlat39 : float(0.0);
    u_xlat16_41 = u_xlat10_0.z * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(u_xlat16_41>=_DepthFoamClip);
#else
    u_xlatb39 = u_xlat16_41>=_DepthFoamClip;
#endif
    u_xlat16_41 = (u_xlatb39) ? _DepthFoamColor.w : 0.0;
    u_xlat16_39 = (-_BendFoamWidth) + 0.5;
    u_xlat16_39 = u_xlat16_39 + _BendFoamOffset;
    u_xlat16_16 = _BendFoamWidth + 0.5;
    u_xlat16_16 = u_xlat16_16 + _BendFoamOffset;
    u_xlat16_16 = (-u_xlat16_39) + u_xlat16_16;
    u_xlat39 = (-u_xlat16_39) + vs_TEXCOORD2.y;
    u_xlat16_16 = float(1.0) / u_xlat16_16;
    u_xlat39 = u_xlat39 * u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat16.x = u_xlat39 * -2.0 + 3.0;
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat39 = u_xlat16.x * u_xlat39 + -0.5;
    u_xlat39 = -abs(u_xlat39) * 2.0 + 1.0;
    u_xlat16_46 = u_xlat10_0.z * u_xlat39;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(u_xlat16_46>=_BendFoamClip);
#else
    u_xlatb39 = u_xlat16_46>=_BendFoamClip;
#endif
    u_xlat16_46 = (u_xlatb39) ? _BendFoamColor.w : 0.0;
    u_xlat16.xy = vec2((-vs_COLOR0.z) + float(1.0), (-vs_COLOR0.w) + float(1.0));
    u_xlat39 = u_xlat16.x * _SplashFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(u_xlat10_0.z>=u_xlat39);
#else
    u_xlatb39 = u_xlat10_0.z>=u_xlat39;
#endif
    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat39 * _SplashFoamColor.w;
    u_xlat29 = u_xlat16.y * _BottomFoamClip;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat10_0.z>=u_xlat29);
#else
    u_xlatb26 = u_xlat10_0.z>=u_xlat29;
#endif
    u_xlat26 = u_xlatb26 ? 1.0 : float(0.0);
    u_xlat29 = u_xlat26 * _BottomFoamColor.w;
    u_xlat16_12.xyz = (-u_xlat16_7.xyz) + _FallFoamColor.xyz;
    u_xlat16_50 = (-vs_COLOR0.x) + 1.0;
    u_xlat16_1.xyz = vec3(u_xlat13) * u_xlat16_12.xyz + u_xlat16_7.xyz;
    u_xlat16_1.w = u_xlat13 * u_xlat16_50 + vs_COLOR0.x;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _DepthFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_41) * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _BendFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat16_46) * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _SplashFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = u_xlat16.xxxx * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6.xyz = (-u_xlat16_1.xyz) + _BottomFoamColor.xyz;
    u_xlat16_6.w = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1 = vec4(u_xlat29) * u_xlat16_6 + u_xlat16_1;
    u_xlat16_6 = u_xlat16_1 * _MainColor;
    u_xlat16_7.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaRange;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _AlphaIntensity;
    u_xlat16_7.x = u_xlat16_6.w * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat13 + u_xlat16_41;
    u_xlat16_41 = u_xlat16_46 + u_xlat16_41;
    u_xlat16_41 = u_xlat39 * _SplashFoamColor.w + u_xlat16_41;
    u_xlat16_41 = u_xlat26 * _BottomFoamColor.w + u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_41>=9.99999975e-05);
#else
    u_xlatb13 = u_xlat16_41>=9.99999975e-05;
#endif
    u_xlat16_41 = (u_xlatb13) ? _FoamRoughnes : 0.0500000007;
    u_xlat16_20.xyz = (bool(u_xlatb13)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : vec3(0.100000001, 0.100000001, 0.100000001);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_6.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_20.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb26){
        u_xlat16_3.xyz = (-vec3(u_xlat16_41)) + vec3(1.0, 1.0, 1.0);
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb26){
        SV_Target0.w = u_xlat16_7.x;
        SV_Target0.xyz = u_xlat16_11.xyz;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb26){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb26 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb26){
        SV_Target0.xyz = u_xlat16_3.xyz;
        SV_Target0.w = u_xlat16_7.x;
        return;
    //ENDIF
    }
    u_xlat3.xyz = (-u_xlat4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat3.xyz = vec3(u_xlat26) * u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyw = u_xlat16_20.xxx * _LightColor0.xyz;
    u_xlat8.xyz = u_xlat16_11.xyw * u_xlat16_11.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_11.xyw = u_xlat5.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat16_20.x = dot(u_xlat16_11.xyw, u_xlat16_11.xyw);
    u_xlat16_20.x = inversesqrt(u_xlat16_20.x);
    u_xlat16_11.xyw = u_xlat16_20.xxx * u_xlat16_11.xyw;
    u_xlat16_0 = dot(u_xlat16_2.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat26 = dot(u_xlat3.xyz, u_xlat16_11.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_39 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_3.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_16 = u_xlat16_0 * u_xlat16_3.x + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_16 * u_xlat16_0 + 1.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999997e-07);
    u_xlat16_0 = u_xlat16_3.x / u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * 0.318309873;
    u_xlat16_0 = min(u_xlat16_0, 64.0);
    u_xlat16_39 = (-u_xlat16_39) * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 + u_xlat16_39;
    u_xlat13 = (u_xlatb13) ? 0.959999979 : 0.899999976;
    u_xlat26 = (-u_xlat26) + 1.0;
    u_xlat16_2.x = u_xlat26 * u_xlat26;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat26 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_2.x;
    u_xlat13 = u_xlat13 * u_xlat16_39 + u_xlat16_20.z;
    u_xlat26 = u_xlat13 * u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * u_xlat13 + 2.0;
    u_xlat0.x = u_xlat26 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_11.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat8.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) * _MainColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vec3(vec3(_ApplyEnvironmet, _ApplyEnvironmet, _ApplyEnvironmet)) * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat26 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat16.x * u_xlat3.x;
    u_xlat16.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!((-u_xlat39)>=u_xlat16.x);
#else
    u_xlatb39 = (-u_xlat39)>=u_xlat16.x;
#endif
    u_xlat16.x = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat39 = (u_xlatb39) ? u_xlat16.x : u_xlat3.x;
    u_xlat39 = log2(u_xlat39);
    u_xlat39 = u_xlat39 * unity_FogColor.w;
    u_xlat39 = exp2(u_xlat39);
    u_xlat39 = min(u_xlat39, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD4.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat3.x) + 2.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat3.x;
    u_xlat3.xyz = vec3(u_xlat16_41) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat42 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat42 = u_xlat42 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat42 = min(max(u_xlat42, 0.0), 1.0);
#else
    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat42) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat42 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat42));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat42);
#endif
    u_xlat17 = u_xlat42 * -1.44269502;
    u_xlat17 = exp2(u_xlat17);
    u_xlat17 = (-u_xlat17) + 1.0;
    u_xlat42 = u_xlat17 / u_xlat42;
    u_xlat16_41 = (u_xlatb4) ? u_xlat42 : 1.0;
    u_xlat13 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb42 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb42 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat4.x = u_xlat13 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat13 = u_xlat4.x / u_xlat13;
    u_xlat16_20.x = (u_xlatb42) ? u_xlat13 : 1.0;
    u_xlat13 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_41 = u_xlat26 * u_xlat16_41;
    u_xlat16_20.x = u_xlat13 * u_xlat16_20.x;
    u_xlat16_41 = exp2((-u_xlat16_41));
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_20.x = exp2((-u_xlat16_20.x));
    u_xlat16_20.x = (-u_xlat16_20.x) + 1.0;
    u_xlat16_20.x = max(u_xlat16_20.x, 0.0);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_20.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_20.x = (-u_xlat0.x) + 2.0;
    u_xlat16_20.x = u_xlat0.x * u_xlat16_20.x;
    u_xlat0.x = u_xlat16_20.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_41 = u_xlat0.x * u_xlat16_41;
    u_xlat0.x = min(u_xlat16_41, _HeigtFogColBase.w);
    u_xlat13 = vs_TEXCOORD4.w * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat13) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
    u_xlat13 = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat39) + 1.0;
    u_xlat0.x = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_7.x;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" }
""
}
}
}
 UsePass "miHoYo/Shadow/ShadowMapPass/LSPSM"
}
}