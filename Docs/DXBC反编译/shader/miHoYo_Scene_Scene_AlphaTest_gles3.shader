//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Scene/Scene_AlphaTest" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[MHYToggle] _ReceiveShadow ("Receive Shadow", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
[MHYToggle] _EnableEmission ("Enable Emission", Float) = 0
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_BaseColor ("BaseColor", 2D) = "white" { }
_MainMaskMapSMBE ("Main Mask Map(SMBE)", 2D) = "white" { }
_NormalMap ("NormalMap", 2D) = "bump" { }
_CubeMap ("CubeMap", Cube) = "white" { }
_EmissionColor ("EmissionColor", Color) = (1,1,1,0)
_EmissionIntensity ("EmissionIntensity", Float) = 1
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 62797
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
in highp vec2 in_TEXCOORD0;
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
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	float _EnableEmission;
uniform 	vec4 _BaseColor_ST;
uniform 	vec4 _MainMaskMapSMBE_ST;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionIntensity;
uniform lowp sampler2D _BaseColor;
uniform lowp sampler2D _MainMaskMapSMBE;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp vec3 u_xlat10_9;
bool u_xlatb9;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_20;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.z;
    u_xlat1.y = vs_TEXCOORD7.z;
    u_xlat1.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_EnableEmission);
#else
    u_xlatb0 = 0.5<_EnableEmission;
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * _MainMaskMapSMBE_ST.xy + _MainMaskMapSMBE_ST.zw;
    u_xlat10_9.xyz = texture(_MainMaskMapSMBE, u_xlat9.xy).xyw;
    u_xlat16_3.xyz = u_xlat10_9.zzz * _EmissionColor.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(_EmissionIntensity);
    u_xlat16_29 = dot(u_xlat16_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-05<u_xlat16_29);
#else
    u_xlatb27 = 9.99999975e-05<u_xlat16_29;
#endif
    u_xlatb0 = u_xlatb27 && u_xlatb0;
    SV_Target0.w = (u_xlatb0) ? 0.00392156886 : 0.0;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_2.w = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = u_xlat16_2.w + u_xlat16_2.w;
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_30)) + u_xlat1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_2.xw = max(u_xlat16_2.xw, vec2(0.00100000005, 0.00100000005));
    u_xlat16_11.x = log2(_CubeMap_TexelSize.z);
    u_xlat16_20 = (-u_xlat10_9.x) + 1.0;
    u_xlat16_30 = u_xlat10_9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_20 = max(u_xlat16_20, 0.00100000005);
    u_xlat16_20 = min(u_xlat16_20, 0.999000013);
    u_xlat16_11.x = u_xlat16_20 * u_xlat16_11.x;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_4.xyz, u_xlat16_11.x);
    u_xlat16_11.x = u_xlat10_1.w + -1.0;
    u_xlat16_11.x = _CubeMap_HDR.w * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.y;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_11.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_1.x = (-u_xlat16_20) + 1.0;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_11.x = u_xlat16_2.w * -5.55472994 + -6.98316002;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_31 = u_xlat16_20 * u_xlat16_30;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * 0.5;
    u_xlat16_20 = max(u_xlat16_20, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * -0.5 + 1.0;
    u_xlat9.xy = vs_TEXCOORD3.xy * _BaseColor_ST.xy + _BaseColor_ST.zw;
    u_xlat10_9.xyz = texture(_BaseColor, u_xlat9.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_9.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_6.xyz = u_xlat10_9.xyz * vec3(u_xlat16_30);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat16_8.xyz = (-u_xlat16_5.xyz) * vec3(u_xlat16_31) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_11.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_11.x = (-u_xlat16_20) + 1.0;
    u_xlat16_30 = u_xlat16_2.x * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = float(1.0) / u_xlat16_11.x;
    u_xlat16_20 = float(1.0) / u_xlat16_30;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_20;
    u_xlat16_4.xyz = u_xlat16_11.xxx * u_xlat16_4.xyz;
    u_xlat16_11.xyz = u_xlat16_2.www * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat16_1.yzw = u_xlat16_3.xyz * vec3(_EmissionIntensity) + u_xlat16_2.xyz;
    u_xlat16_29 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_3.w = max(u_xlat16_1.y, u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_1.y / u_xlat16_3.w, u_xlat16_1.z / u_xlat16_3.w, u_xlat16_1.w / u_xlat16_3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(1.0<u_xlat16_3.w);
#else
    u_xlatb9 = 1.0<u_xlat16_3.w;
#endif
    u_xlat16_3 = (bool(u_xlatb9)) ? u_xlat16_3 : u_xlat16_1.yzwx;
    SV_Target1.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : u_xlat16_2.xyz;
    u_xlat16_2.x = 0.400000006;
    SV_Target1.w = (u_xlatb0) ? u_xlat16_3.w : u_xlat16_2.x;
    u_xlat16_9 = u_xlat16_3.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat9.x = sqrt(u_xlat16_9);
    SV_Target2.w = (u_xlatb0) ? u_xlat9.x : u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : u_xlat16_5.z;
    SV_Target2.xy = u_xlat16_5.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
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
in highp vec2 in_TEXCOORD0;
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
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	vec4 _BaseColor_ST;
uniform 	vec4 _MainMaskMapSMBE_ST;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionIntensity;
uniform lowp sampler2D _BaseColor;
uniform lowp sampler2D _MainMaskMapSMBE;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp vec3 u_xlat10_9;
bool u_xlatb9;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_20;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.z;
    u_xlat1.y = vs_TEXCOORD7.z;
    u_xlat1.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_EnableEmission);
#else
    u_xlatb0 = 0.5<_EnableEmission;
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * _MainMaskMapSMBE_ST.xy + _MainMaskMapSMBE_ST.zw;
    u_xlat10_9.xyz = texture(_MainMaskMapSMBE, u_xlat9.xy).xyw;
    u_xlat16_3.xyz = u_xlat10_9.zzz * _EmissionColor.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(_EmissionIntensity);
    u_xlat16_29 = dot(u_xlat16_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-05<u_xlat16_29);
#else
    u_xlatb27 = 9.99999975e-05<u_xlat16_29;
#endif
    u_xlatb0 = u_xlatb27 && u_xlatb0;
    SV_Target0.w = (u_xlatb0) ? 0.00392156886 : 0.0;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_2.w = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = u_xlat16_2.w + u_xlat16_2.w;
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_30)) + u_xlat1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_2.xw = max(u_xlat16_2.xw, vec2(0.00100000005, 0.00100000005));
    u_xlat16_11.x = log2(_CubeMap_TexelSize.z);
    u_xlat16_20 = (-u_xlat10_9.x) + 1.0;
    u_xlat16_30 = u_xlat10_9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_20 = max(u_xlat16_20, 0.00100000005);
    u_xlat16_20 = min(u_xlat16_20, 0.999000013);
    u_xlat16_11.x = u_xlat16_20 * u_xlat16_11.x;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_4.xyz, u_xlat16_11.x);
    u_xlat16_11.x = u_xlat10_1.w + -1.0;
    u_xlat16_11.x = _CubeMap_HDR.w * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.y;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_11.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_1.x = (-u_xlat16_20) + 1.0;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_11.x = u_xlat16_2.w * -5.55472994 + -6.98316002;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_31 = u_xlat16_20 * u_xlat16_30;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * 0.5;
    u_xlat16_20 = max(u_xlat16_20, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * -0.5 + 1.0;
    u_xlat9.xy = vs_TEXCOORD3.xy * _BaseColor_ST.xy + _BaseColor_ST.zw;
    u_xlat10_9.xyz = texture(_BaseColor, u_xlat9.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_9.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_6.xyz = u_xlat10_9.xyz * vec3(u_xlat16_30);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat16_8.xyz = (-u_xlat16_5.xyz) * vec3(u_xlat16_31) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_11.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_11.x = (-u_xlat16_20) + 1.0;
    u_xlat16_30 = u_xlat16_2.x * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = float(1.0) / u_xlat16_11.x;
    u_xlat16_20 = float(1.0) / u_xlat16_30;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_20;
    u_xlat16_4.xyz = u_xlat16_11.xxx * u_xlat16_4.xyz;
    u_xlat16_11.xyz = u_xlat16_2.www * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat16_1.yzw = u_xlat16_3.xyz * vec3(_EmissionIntensity) + u_xlat16_2.xyz;
    u_xlat16_29 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_3.w = max(u_xlat16_1.y, u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_1.y / u_xlat16_3.w, u_xlat16_1.z / u_xlat16_3.w, u_xlat16_1.w / u_xlat16_3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(1.0<u_xlat16_3.w);
#else
    u_xlatb9 = 1.0<u_xlat16_3.w;
#endif
    u_xlat16_3 = (bool(u_xlatb9)) ? u_xlat16_3 : u_xlat16_1.yzwx;
    SV_Target1.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : u_xlat16_2.xyz;
    u_xlat16_2.x = 0.400000006;
    SV_Target1.w = (u_xlatb0) ? u_xlat16_3.w : u_xlat16_2.x;
    u_xlat16_9 = u_xlat16_3.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat9.x = sqrt(u_xlat16_9);
    SV_Target2.w = (u_xlatb0) ? u_xlat9.x : u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : u_xlat16_5.z;
    SV_Target2.xy = u_xlat16_5.xy;
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
in highp vec2 in_TEXCOORD0;
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
float u_xlat10;
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
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	float _EnableEmission;
uniform 	vec4 _BaseColor_ST;
uniform 	vec4 _MainMaskMapSMBE_ST;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionIntensity;
uniform lowp sampler2D _BaseColor;
uniform lowp sampler2D _MainMaskMapSMBE;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp vec3 u_xlat10_9;
bool u_xlatb9;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_20;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.z;
    u_xlat1.y = vs_TEXCOORD7.z;
    u_xlat1.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_EnableEmission);
#else
    u_xlatb0 = 0.5<_EnableEmission;
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * _MainMaskMapSMBE_ST.xy + _MainMaskMapSMBE_ST.zw;
    u_xlat10_9.xyz = texture(_MainMaskMapSMBE, u_xlat9.xy).xyw;
    u_xlat16_3.xyz = u_xlat10_9.zzz * _EmissionColor.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(_EmissionIntensity);
    u_xlat16_29 = dot(u_xlat16_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-05<u_xlat16_29);
#else
    u_xlatb27 = 9.99999975e-05<u_xlat16_29;
#endif
    u_xlatb0 = u_xlatb27 && u_xlatb0;
    SV_Target0.w = (u_xlatb0) ? 0.00392156886 : 0.0;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_2.w = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = u_xlat16_2.w + u_xlat16_2.w;
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_30)) + u_xlat1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_2.xw = max(u_xlat16_2.xw, vec2(0.00100000005, 0.00100000005));
    u_xlat16_11.x = log2(_CubeMap_TexelSize.z);
    u_xlat16_20 = (-u_xlat10_9.x) + 1.0;
    u_xlat16_30 = u_xlat10_9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_20 = max(u_xlat16_20, 0.00100000005);
    u_xlat16_20 = min(u_xlat16_20, 0.999000013);
    u_xlat16_11.x = u_xlat16_20 * u_xlat16_11.x;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_4.xyz, u_xlat16_11.x);
    u_xlat16_11.x = u_xlat10_1.w + -1.0;
    u_xlat16_11.x = _CubeMap_HDR.w * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.y;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_11.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_1.x = (-u_xlat16_20) + 1.0;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_11.x = u_xlat16_2.w * -5.55472994 + -6.98316002;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_31 = u_xlat16_20 * u_xlat16_30;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * 0.5;
    u_xlat16_20 = max(u_xlat16_20, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * -0.5 + 1.0;
    u_xlat9.xy = vs_TEXCOORD3.xy * _BaseColor_ST.xy + _BaseColor_ST.zw;
    u_xlat10_9.xyz = texture(_BaseColor, u_xlat9.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_9.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_6.xyz = u_xlat10_9.xyz * vec3(u_xlat16_30);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat16_8.xyz = (-u_xlat16_5.xyz) * vec3(u_xlat16_31) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_11.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_11.x = (-u_xlat16_20) + 1.0;
    u_xlat16_30 = u_xlat16_2.x * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = float(1.0) / u_xlat16_11.x;
    u_xlat16_20 = float(1.0) / u_xlat16_30;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_20;
    u_xlat16_4.xyz = u_xlat16_11.xxx * u_xlat16_4.xyz;
    u_xlat16_11.xyz = u_xlat16_2.www * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat16_1.yzw = u_xlat16_3.xyz * vec3(_EmissionIntensity) + u_xlat16_2.xyz;
    u_xlat16_29 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_3.w = max(u_xlat16_1.y, u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_1.y / u_xlat16_3.w, u_xlat16_1.z / u_xlat16_3.w, u_xlat16_1.w / u_xlat16_3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(1.0<u_xlat16_3.w);
#else
    u_xlatb9 = 1.0<u_xlat16_3.w;
#endif
    u_xlat16_3 = (bool(u_xlatb9)) ? u_xlat16_3 : u_xlat16_1.yzwx;
    SV_Target1.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : u_xlat16_2.xyz;
    u_xlat16_2.x = 0.400000006;
    SV_Target1.w = (u_xlatb0) ? u_xlat16_3.w : u_xlat16_2.x;
    u_xlat16_9 = u_xlat16_3.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat9.x = sqrt(u_xlat16_9);
    SV_Target2.w = (u_xlatb0) ? u_xlat9.x : u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : u_xlat16_5.z;
    SV_Target2.xy = u_xlat16_5.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
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
in highp vec2 in_TEXCOORD0;
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
float u_xlat10;
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
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	vec4 _BaseColor_ST;
uniform 	vec4 _MainMaskMapSMBE_ST;
uniform 	vec4 _NormalMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionIntensity;
uniform lowp sampler2D _BaseColor;
uniform lowp sampler2D _MainMaskMapSMBE;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec2 u_xlat9;
mediump float u_xlat16_9;
lowp vec3 u_xlat10_9;
bool u_xlatb9;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_20;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD5.z;
    u_xlat1.y = vs_TEXCOORD7.z;
    u_xlat1.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_EnableEmission);
#else
    u_xlatb0 = 0.5<_EnableEmission;
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * _MainMaskMapSMBE_ST.xy + _MainMaskMapSMBE_ST.zw;
    u_xlat10_9.xyz = texture(_MainMaskMapSMBE, u_xlat9.xy).xyw;
    u_xlat16_3.xyz = u_xlat10_9.zzz * _EmissionColor.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(_EmissionIntensity);
    u_xlat16_29 = dot(u_xlat16_4.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(9.99999975e-05<u_xlat16_29);
#else
    u_xlatb27 = 9.99999975e-05<u_xlat16_29;
#endif
    u_xlatb0 = u_xlatb27 && u_xlatb0;
    SV_Target0.w = (u_xlatb0) ? 0.00392156886 : 0.0;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_2.w = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = u_xlat16_2.w + u_xlat16_2.w;
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_30)) + u_xlat1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_2.xw = max(u_xlat16_2.xw, vec2(0.00100000005, 0.00100000005));
    u_xlat16_11.x = log2(_CubeMap_TexelSize.z);
    u_xlat16_20 = (-u_xlat10_9.x) + 1.0;
    u_xlat16_30 = u_xlat10_9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_20 = max(u_xlat16_20, 0.00100000005);
    u_xlat16_20 = min(u_xlat16_20, 0.999000013);
    u_xlat16_11.x = u_xlat16_20 * u_xlat16_11.x;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_4.xyz, u_xlat16_11.x);
    u_xlat16_11.x = u_xlat10_1.w + -1.0;
    u_xlat16_11.x = _CubeMap_HDR.w * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.y;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _CubeMap_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_11.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_1.x = (-u_xlat16_20) + 1.0;
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_11.x = u_xlat16_2.w * -5.55472994 + -6.98316002;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat16_31 = u_xlat16_20 * u_xlat16_30;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_20 * 0.5;
    u_xlat16_20 = max(u_xlat16_20, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * -0.5 + 1.0;
    u_xlat9.xy = vs_TEXCOORD3.xy * _BaseColor_ST.xy + _BaseColor_ST.zw;
    u_xlat10_9.xyz = texture(_BaseColor, u_xlat9.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_9.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_6.xyz = u_xlat10_9.xyz * vec3(u_xlat16_30);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat16_8.xyz = (-u_xlat16_5.xyz) * vec3(u_xlat16_31) + vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_11.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_11.x = (-u_xlat16_20) + 1.0;
    u_xlat16_30 = u_xlat16_2.x * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = u_xlat16_2.w * u_xlat16_11.x + u_xlat16_20;
    u_xlat16_11.x = float(1.0) / u_xlat16_11.x;
    u_xlat16_20 = float(1.0) / u_xlat16_30;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_20;
    u_xlat16_4.xyz = u_xlat16_11.xxx * u_xlat16_4.xyz;
    u_xlat16_11.xyz = u_xlat16_2.www * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xyz * u_xlat16_2.xxx + u_xlat16_6.xyz;
    u_xlat16_1.yzw = u_xlat16_3.xyz * vec3(_EmissionIntensity) + u_xlat16_2.xyz;
    u_xlat16_29 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_3.w = max(u_xlat16_1.y, u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_1.y / u_xlat16_3.w, u_xlat16_1.z / u_xlat16_3.w, u_xlat16_1.w / u_xlat16_3.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(1.0<u_xlat16_3.w);
#else
    u_xlatb9 = 1.0<u_xlat16_3.w;
#endif
    u_xlat16_3 = (bool(u_xlatb9)) ? u_xlat16_3 : u_xlat16_1.yzwx;
    SV_Target1.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : u_xlat16_2.xyz;
    u_xlat16_2.x = 0.400000006;
    SV_Target1.w = (u_xlatb0) ? u_xlat16_3.w : u_xlat16_2.x;
    u_xlat16_9 = u_xlat16_3.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat9.x = sqrt(u_xlat16_9);
    SV_Target2.w = (u_xlatb0) ? u_xlat9.x : u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : u_xlat16_5.z;
    SV_Target2.xy = u_xlat16_5.xy;
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 67331
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
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
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
bool u_xlatb0;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
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
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
bool u_xlatb0;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 167988
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
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
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
bool u_xlatb0;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
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
uniform 	float _CutOff;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
bool u_xlatb0;
void main()
{
    u_xlat0 = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 199756
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
bool u_xlatb0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
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
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
bool u_xlatb0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.x = (-_CutOff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
}
Fallback "Legacy Shaders/VertexLit"
CustomEditor "MiHoYoASEMaterialInspector"
}