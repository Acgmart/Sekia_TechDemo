//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Test_VertexBlend" {
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
_DiffuseArray ("DiffuseArray", 2DArray) = "" { }
_MaskArray ("MaskArray", 2DArray) = "" { }
_NormalArray ("NormalArray", 2DArray) = "" { }
_NormalScale ("NormalScale", Range(0, 5)) = 1
_Specular ("Specular", Range(0, 1)) = 0
[MHYToggle] _R ("R", Float) = 0
_RIndex ("R Index", Float) = 7
_RContrast ("R Contrast", Range(0, 2)) = 0
_RStrength ("R Strength", Range(1, 2)) = 1
_RTransparency ("R Transparency", Range(0, 1)) = 0
_GIndex ("G Index", Float) = 7
[MHYToggle] _G ("G", Float) = 0
[MHYToggle] _A ("A", Float) = 0
_GContrast ("G Contrast", Range(0, 2)) = 0
_GStrength ("G Strength", Range(1, 2)) = 1
_GTransparency ("G Transparency", Range(0, 1)) = 0
[MHYToggle] _B ("B", Float) = 0
_BContrast ("B Contrast", Range(0, 2)) = 0
_BStrength ("B Strength", Range(1, 2)) = 0
_Range ("Range", Range(-0.5, 3)) = 1
_WetSpecular ("Wet Specular", Color) = (0.6691177,0.9315417,1,0)
[Header(DistanceFade)] [Toggle(_DISTANCEINVERT_ON)] _DistanceInvert ("DistanceInvert", Float) = 0
[MHYToggle] _DistanceFadeEnable ("DistanceFade Enable", Float) = 0
_VertexMixDistance ("VertexMixDistance", Range(0, 300)) = 150
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 30641
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat15 * 0.5;
    u_xlat4.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD4.x = (-u_xlat15);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.yzw = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _A;
uniform 	mediump float _G;
uniform 	mediump float _R;
uniform 	mediump float _B;
uniform 	vec4 _DiffuseArray_ST;
uniform 	mediump float _BContrast;
uniform 	mediump float _BStrength;
uniform 	vec4 _MaskArray_ST;
uniform 	mediump float _DistanceFadeEnable;
uniform 	mediump float _VertexMixDistance;
uniform 	mediump float _RIndex;
uniform 	mediump float _RContrast;
uniform 	mediump float _RStrength;
uniform 	mediump float _RTransparency;
uniform 	mediump float _GIndex;
uniform 	mediump float _GContrast;
uniform 	mediump float _GStrength;
uniform 	mediump float _GTransparency;
uniform 	mediump float _Range;
uniform 	mediump float _Specular;
uniform 	mediump vec4 _WetSpecular;
uniform 	vec4 _NormalArray_ST;
uniform 	mediump float _NormalScale;
uniform lowp sampler2DArray _DiffuseArray;
uniform lowp sampler2DArray _MaskArray;
uniform lowp sampler2DArray _NormalArray;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
bvec3 u_xlatb7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
mediump vec2 u_xlat16_24;
vec2 u_xlat27;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _VertexMixDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(_DistanceFadeEnable==1.0);
#else
    u_xlatb11 = _DistanceFadeEnable==1.0;
#endif
    u_xlat16_1.x = (u_xlatb11) ? u_xlat0.x : 0.0;
    u_xlat16_12 = u_xlat16_1.x + _RTransparency;
    u_xlat0.xyz = max(vs_COLOR0.zxy, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x * _BStrength;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_23 = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_1.x + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x + _GTransparency;
    u_xlat16_2.x = _BContrast * 2.0 + 1.0;
    u_xlat3.xy = vs_TEXCOORD3.xy * _MaskArray_ST.xy + _MaskArray_ST.zw;
    u_xlat4.zw = floor(vs_TEXCOORD3.wz);
    u_xlat3.zw = u_xlat4.zw;
    u_xlat10_5.xy = texture(_MaskArray, u_xlat3.xyw).xy;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat10_5.x);
    u_xlat16_23 = u_xlat16_23 + 2.0;
    u_xlat27.xy = texture(_MaskArray, u_xlat3.xyz).xy;
    u_xlat6.xy = u_xlat3.xy;
    u_xlat16_13 = u_xlat0.x * 2.0 + (-u_xlat27.x);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_13);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_23 * u_xlat16_2.x + (-_BContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = (-u_xlat16_34) + u_xlat16_23;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_2.xy = (-u_xlat27.xy) + u_xlat10_5.xy;
    u_xlat16_2.xy = vec2(u_xlat16_23) * u_xlat16_2.xy + u_xlat27.xy;
    u_xlatb7.xyz = equal(vec4(_B, _R, _G, _B), vec4(1.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat16_2.xy = (u_xlatb7.x) ? u_xlat16_2.xy : u_xlat27.xy;
    u_xlat0.x = u_xlat0.y * _RStrength;
    u_xlat11 = u_xlat0.z * _GStrength;
    u_xlat0.y = exp2(u_xlat11);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat16_34 = u_xlat0.x * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat6.z = _RIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_24.x = (-u_xlat10_0.x) + u_xlat16_24.x;
    u_xlat16_8.xy = (-u_xlat16_2.xy) + u_xlat10_0.xz;
    u_xlat16_24.x = u_xlat16_24.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _RContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_RContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD3.xy * _NormalArray_ST.xy + _NormalArray_ST.zw;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyw).xyz;
    u_xlat10_5.xyz = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_23) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.x) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _RIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_12) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.y) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _GIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_34 = (-u_xlat0.y) + 1.0;
    u_xlat6.z = _GIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_34 = (-u_xlat10_0.x) + u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 + 2.0;
    u_xlat16_24.xy = vec2(u_xlat16_12) * u_xlat16_8.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.y) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_24.x = u_xlat0.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = u_xlat16_24.x + 1.0;
    u_xlat16_34 = u_xlat16_34 + (-u_xlat16_24.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _GContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_GContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (u_xlatb7.z) ? u_xlat16_8.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat16_24.xy = u_xlat10_0.xz + (-u_xlat16_2.xy);
    u_xlat16_24.xy = u_xlat16_1.xx * u_xlat16_24.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.z) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_34 = vs_COLOR0.w * 2.0 + (-u_xlat16_2.x);
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) + _Range;
    u_xlat16_2.x = u_xlat16_2.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_3.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(_A==1.0);
#else
    u_xlatb33 = _A==1.0;
#endif
    u_xlat16_2.xzw = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_8.xyz;
    u_xlat0.x = vs_TEXCOORD5.z;
    u_xlat0.y = vs_TEXCOORD6.z;
    u_xlat0.z = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat16_8.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat16_8.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat16_8.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD5.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat16_9.xyz = u_xlat0.zxy * u_xlat5.yzx;
    u_xlat16_9.xyz = u_xlat5.xyz * u_xlat0.xyz + (-u_xlat16_9.xyz);
    u_xlat16_41 = dot(u_xlat3.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz;
    u_xlat16_8.y = dot(u_xlat16_8.xyz, u_xlat16_2.xzw);
    u_xlat16_10.xyz = u_xlat3.zxy * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat3.yzx * u_xlat5.yzx + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz;
    u_xlat16_8.x = dot(u_xlat16_9.xyz, u_xlat16_2.xzw);
    u_xlat16_8.z = dot(u_xlat16_10.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat4.xy = vs_TEXCOORD3.xy * _DiffuseArray_ST.xy + _DiffuseArray_ST.zw;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyw).xyz;
    u_xlat3.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_2.xzw = u_xlat10_0.xyz + (-u_xlat3.xyz);
    u_xlat16_2.xzw = vec3(u_xlat16_23) * u_xlat16_2.xzw + u_xlat3.xyz;
    u_xlat16_2.xzw = (u_xlatb7.x) ? u_xlat16_2.xzw : u_xlat3.xyz;
    u_xlat4.z = _RIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_2.xzw = (u_xlatb7.y) ? u_xlat16_8.xyz : u_xlat16_2.xzw;
    u_xlat4.z = _GIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_1.xyz = (u_xlatb7.z) ? u_xlat16_1.xyz : u_xlat16_2.xzw;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    SV_Target1.w = 0.400000006;
    u_xlat16_0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat0.x = u_xlat16_34 * u_xlat16_0.x + u_xlat16_2.y;
    SV_Target2.w = (u_xlatb33) ? u_xlat0.x : u_xlat16_2.y;
    u_xlat0.x = dot(vs_TEXCOORD4.yzw, vs_TEXCOORD4.yzw);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = vec3(u_xlat0.x * vs_TEXCOORD4.y, u_xlat0.x * vs_TEXCOORD4.z, u_xlat0.x * vs_TEXCOORD4.w);
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x + 0.00999999978;
    u_xlat16_1.xyz = _WetSpecular.xyz * u_xlat16_1.xxx + (-vec3(vec3(_Specular, _Specular, _Specular)));
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz + vec3(vec3(_Specular, _Specular, _Specular));
    u_xlat16_1.xyz = (bool(u_xlatb33)) ? u_xlat16_1.xyz : vec3(vec4(_Specular, _Specular, _Specular, _Specular));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_34 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_34 : u_xlat16_1.z;
    SV_Target2.xy = u_xlat16_1.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat15;
float u_xlat18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat1.x;
    vs_TEXCOORD4.x = (-u_xlat1.x);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.yzw = u_xlat5.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _A;
uniform 	mediump float _G;
uniform 	mediump float _R;
uniform 	mediump float _B;
uniform 	vec4 _DiffuseArray_ST;
uniform 	mediump float _BContrast;
uniform 	mediump float _BStrength;
uniform 	vec4 _MaskArray_ST;
uniform 	mediump float _DistanceFadeEnable;
uniform 	mediump float _VertexMixDistance;
uniform 	mediump float _RIndex;
uniform 	mediump float _RContrast;
uniform 	mediump float _RStrength;
uniform 	mediump float _RTransparency;
uniform 	mediump float _GIndex;
uniform 	mediump float _GContrast;
uniform 	mediump float _GStrength;
uniform 	mediump float _GTransparency;
uniform 	mediump float _Range;
uniform 	mediump float _Specular;
uniform 	mediump vec4 _WetSpecular;
uniform 	vec4 _NormalArray_ST;
uniform 	mediump float _NormalScale;
uniform lowp sampler2DArray _DiffuseArray;
uniform lowp sampler2DArray _MaskArray;
uniform lowp sampler2DArray _NormalArray;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
bvec3 u_xlatb7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
mediump vec2 u_xlat16_24;
vec2 u_xlat27;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _VertexMixDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(_DistanceFadeEnable==1.0);
#else
    u_xlatb11 = _DistanceFadeEnable==1.0;
#endif
    u_xlat16_1.x = (u_xlatb11) ? u_xlat0.x : 0.0;
    u_xlat16_12 = u_xlat16_1.x + _RTransparency;
    u_xlat0.xyz = max(vs_COLOR0.zxy, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x * _BStrength;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_23 = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_1.x + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x + _GTransparency;
    u_xlat16_2.x = _BContrast * 2.0 + 1.0;
    u_xlat3.xy = vs_TEXCOORD3.xy * _MaskArray_ST.xy + _MaskArray_ST.zw;
    u_xlat4.zw = floor(vs_TEXCOORD3.wz);
    u_xlat3.zw = u_xlat4.zw;
    u_xlat10_5.xy = texture(_MaskArray, u_xlat3.xyw).xy;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat10_5.x);
    u_xlat16_23 = u_xlat16_23 + 2.0;
    u_xlat27.xy = texture(_MaskArray, u_xlat3.xyz).xy;
    u_xlat6.xy = u_xlat3.xy;
    u_xlat16_13 = u_xlat0.x * 2.0 + (-u_xlat27.x);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_13);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_23 * u_xlat16_2.x + (-_BContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = (-u_xlat16_34) + u_xlat16_23;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_2.xy = (-u_xlat27.xy) + u_xlat10_5.xy;
    u_xlat16_2.xy = vec2(u_xlat16_23) * u_xlat16_2.xy + u_xlat27.xy;
    u_xlatb7.xyz = equal(vec4(_B, _R, _G, _B), vec4(1.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat16_2.xy = (u_xlatb7.x) ? u_xlat16_2.xy : u_xlat27.xy;
    u_xlat0.x = u_xlat0.y * _RStrength;
    u_xlat11 = u_xlat0.z * _GStrength;
    u_xlat0.y = exp2(u_xlat11);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat16_34 = u_xlat0.x * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat6.z = _RIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_24.x = (-u_xlat10_0.x) + u_xlat16_24.x;
    u_xlat16_8.xy = (-u_xlat16_2.xy) + u_xlat10_0.xz;
    u_xlat16_24.x = u_xlat16_24.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _RContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_RContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD3.xy * _NormalArray_ST.xy + _NormalArray_ST.zw;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyw).xyz;
    u_xlat10_5.xyz = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_23) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.x) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _RIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_12) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.y) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _GIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_34 = (-u_xlat0.y) + 1.0;
    u_xlat6.z = _GIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_34 = (-u_xlat10_0.x) + u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 + 2.0;
    u_xlat16_24.xy = vec2(u_xlat16_12) * u_xlat16_8.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.y) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_24.x = u_xlat0.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = u_xlat16_24.x + 1.0;
    u_xlat16_34 = u_xlat16_34 + (-u_xlat16_24.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _GContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_GContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (u_xlatb7.z) ? u_xlat16_8.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat16_24.xy = u_xlat10_0.xz + (-u_xlat16_2.xy);
    u_xlat16_24.xy = u_xlat16_1.xx * u_xlat16_24.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.z) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_34 = vs_COLOR0.w * 2.0 + (-u_xlat16_2.x);
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) + _Range;
    u_xlat16_2.x = u_xlat16_2.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_3.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(_A==1.0);
#else
    u_xlatb33 = _A==1.0;
#endif
    u_xlat16_2.xzw = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_8.xyz;
    u_xlat0.x = vs_TEXCOORD5.z;
    u_xlat0.y = vs_TEXCOORD6.z;
    u_xlat0.z = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat16_8.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat16_8.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat16_8.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD5.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat16_9.xyz = u_xlat0.zxy * u_xlat5.yzx;
    u_xlat16_9.xyz = u_xlat5.xyz * u_xlat0.xyz + (-u_xlat16_9.xyz);
    u_xlat16_41 = dot(u_xlat3.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz;
    u_xlat16_8.y = dot(u_xlat16_8.xyz, u_xlat16_2.xzw);
    u_xlat16_10.xyz = u_xlat3.zxy * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat3.yzx * u_xlat5.yzx + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz;
    u_xlat16_8.x = dot(u_xlat16_9.xyz, u_xlat16_2.xzw);
    u_xlat16_8.z = dot(u_xlat16_10.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat4.xy = vs_TEXCOORD3.xy * _DiffuseArray_ST.xy + _DiffuseArray_ST.zw;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyw).xyz;
    u_xlat3.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_2.xzw = u_xlat10_0.xyz + (-u_xlat3.xyz);
    u_xlat16_2.xzw = vec3(u_xlat16_23) * u_xlat16_2.xzw + u_xlat3.xyz;
    u_xlat16_2.xzw = (u_xlatb7.x) ? u_xlat16_2.xzw : u_xlat3.xyz;
    u_xlat4.z = _RIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_2.xzw = (u_xlatb7.y) ? u_xlat16_8.xyz : u_xlat16_2.xzw;
    u_xlat4.z = _GIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_1.xyz = (u_xlatb7.z) ? u_xlat16_1.xyz : u_xlat16_2.xzw;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    SV_Target1.w = 0.400000006;
    u_xlat16_0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat0.x = u_xlat16_34 * u_xlat16_0.x + u_xlat16_2.y;
    SV_Target2.w = (u_xlatb33) ? u_xlat0.x : u_xlat16_2.y;
    u_xlat0.x = dot(vs_TEXCOORD4.yzw, vs_TEXCOORD4.yzw);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = vec3(u_xlat0.x * vs_TEXCOORD4.y, u_xlat0.x * vs_TEXCOORD4.z, u_xlat0.x * vs_TEXCOORD4.w);
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x + 0.00999999978;
    u_xlat16_1.xyz = _WetSpecular.xyz * u_xlat16_1.xxx + (-vec3(vec3(_Specular, _Specular, _Specular)));
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz + vec3(vec3(_Specular, _Specular, _Specular));
    u_xlat16_1.xyz = (bool(u_xlatb33)) ? u_xlat16_1.xyz : vec3(vec4(_Specular, _Specular, _Specular, _Specular));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_34 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_34 : u_xlat16_1.z;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_DISTANCEINVERT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat15 * 0.5;
    u_xlat4.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
    vs_TEXCOORD4.x = (-u_xlat15);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD4.yzw = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _A;
uniform 	mediump float _G;
uniform 	mediump float _R;
uniform 	mediump float _B;
uniform 	vec4 _DiffuseArray_ST;
uniform 	mediump float _BContrast;
uniform 	mediump float _BStrength;
uniform 	vec4 _MaskArray_ST;
uniform 	mediump float _DistanceFadeEnable;
uniform 	mediump float _VertexMixDistance;
uniform 	mediump float _RIndex;
uniform 	mediump float _RContrast;
uniform 	mediump float _RStrength;
uniform 	mediump float _RTransparency;
uniform 	mediump float _GIndex;
uniform 	mediump float _GContrast;
uniform 	mediump float _GStrength;
uniform 	mediump float _GTransparency;
uniform 	mediump float _Range;
uniform 	mediump float _Specular;
uniform 	mediump vec4 _WetSpecular;
uniform 	vec4 _NormalArray_ST;
uniform 	mediump float _NormalScale;
uniform lowp sampler2DArray _DiffuseArray;
uniform lowp sampler2DArray _MaskArray;
uniform lowp sampler2DArray _NormalArray;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
bvec3 u_xlatb7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
mediump vec2 u_xlat16_24;
vec2 u_xlat27;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _VertexMixDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(_DistanceFadeEnable==1.0);
#else
    u_xlatb11 = _DistanceFadeEnable==1.0;
#endif
    u_xlat16_1.x = (u_xlatb11) ? u_xlat0.x : 0.0;
    u_xlat16_12 = u_xlat16_1.x + _RTransparency;
    u_xlat0.xyz = max(vs_COLOR0.zxy, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x * _BStrength;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_23 = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_1.x + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x + _GTransparency;
    u_xlat16_2.x = _BContrast * 2.0 + 1.0;
    u_xlat3.xy = vs_TEXCOORD3.xy * _MaskArray_ST.xy + _MaskArray_ST.zw;
    u_xlat4.zw = floor(vs_TEXCOORD3.wz);
    u_xlat3.zw = u_xlat4.zw;
    u_xlat10_5.xy = texture(_MaskArray, u_xlat3.xyw).xy;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat10_5.x);
    u_xlat16_23 = u_xlat16_23 + 2.0;
    u_xlat27.xy = texture(_MaskArray, u_xlat3.xyz).xy;
    u_xlat6.xy = u_xlat3.xy;
    u_xlat16_13 = u_xlat0.x * 2.0 + (-u_xlat27.x);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_13);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_23 * u_xlat16_2.x + (-_BContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = (-u_xlat16_34) + u_xlat16_23;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_2.xy = (-u_xlat27.xy) + u_xlat10_5.xy;
    u_xlat16_2.xy = vec2(u_xlat16_23) * u_xlat16_2.xy + u_xlat27.xy;
    u_xlatb7.xyz = equal(vec4(_B, _R, _G, _B), vec4(1.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat16_2.xy = (u_xlatb7.x) ? u_xlat16_2.xy : u_xlat27.xy;
    u_xlat0.x = u_xlat0.y * _RStrength;
    u_xlat11 = u_xlat0.z * _GStrength;
    u_xlat0.y = exp2(u_xlat11);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat16_34 = u_xlat0.x * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat6.z = _RIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_24.x = (-u_xlat10_0.x) + u_xlat16_24.x;
    u_xlat16_8.xy = (-u_xlat16_2.xy) + u_xlat10_0.xz;
    u_xlat16_24.x = u_xlat16_24.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _RContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_RContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD3.xy * _NormalArray_ST.xy + _NormalArray_ST.zw;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyw).xyz;
    u_xlat10_5.xyz = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_23) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.x) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _RIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_12) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.y) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _GIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_34 = (-u_xlat0.y) + 1.0;
    u_xlat6.z = _GIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_34 = (-u_xlat10_0.x) + u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 + 2.0;
    u_xlat16_24.xy = vec2(u_xlat16_12) * u_xlat16_8.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.y) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_24.x = u_xlat0.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = u_xlat16_24.x + 1.0;
    u_xlat16_34 = u_xlat16_34 + (-u_xlat16_24.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _GContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_GContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (u_xlatb7.z) ? u_xlat16_8.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat16_24.xy = u_xlat10_0.xz + (-u_xlat16_2.xy);
    u_xlat16_24.xy = u_xlat16_1.xx * u_xlat16_24.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.z) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_34 = vs_COLOR0.w * 2.0 + (-u_xlat16_2.x);
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) + _Range;
    u_xlat16_2.x = u_xlat16_2.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_3.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(_A==1.0);
#else
    u_xlatb33 = _A==1.0;
#endif
    u_xlat16_2.xzw = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_8.xyz;
    u_xlat0.x = vs_TEXCOORD5.z;
    u_xlat0.y = vs_TEXCOORD6.z;
    u_xlat0.z = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat16_8.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat16_8.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat16_8.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD5.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat16_9.xyz = u_xlat0.zxy * u_xlat5.yzx;
    u_xlat16_9.xyz = u_xlat5.xyz * u_xlat0.xyz + (-u_xlat16_9.xyz);
    u_xlat16_41 = dot(u_xlat3.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz;
    u_xlat16_8.y = dot(u_xlat16_8.xyz, u_xlat16_2.xzw);
    u_xlat16_10.xyz = u_xlat3.zxy * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat3.yzx * u_xlat5.yzx + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz;
    u_xlat16_8.x = dot(u_xlat16_9.xyz, u_xlat16_2.xzw);
    u_xlat16_8.z = dot(u_xlat16_10.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat4.xy = vs_TEXCOORD3.xy * _DiffuseArray_ST.xy + _DiffuseArray_ST.zw;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyw).xyz;
    u_xlat3.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_2.xzw = u_xlat10_0.xyz + (-u_xlat3.xyz);
    u_xlat16_2.xzw = vec3(u_xlat16_23) * u_xlat16_2.xzw + u_xlat3.xyz;
    u_xlat16_2.xzw = (u_xlatb7.x) ? u_xlat16_2.xzw : u_xlat3.xyz;
    u_xlat4.z = _RIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_2.xzw = (u_xlatb7.y) ? u_xlat16_8.xyz : u_xlat16_2.xzw;
    u_xlat4.z = _GIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_1.xyz = (u_xlatb7.z) ? u_xlat16_1.xyz : u_xlat16_2.xzw;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    SV_Target1.w = 0.400000006;
    u_xlat16_0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat0.x = u_xlat16_34 * u_xlat16_0.x + u_xlat16_2.y;
    SV_Target2.w = (u_xlatb33) ? u_xlat0.x : u_xlat16_2.y;
    u_xlat0.x = dot(vs_TEXCOORD4.yzw, vs_TEXCOORD4.yzw);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = vec3(u_xlat0.x * vs_TEXCOORD4.y, u_xlat0.x * vs_TEXCOORD4.z, u_xlat0.x * vs_TEXCOORD4.w);
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x + 0.00999999978;
    u_xlat16_1.xyz = _WetSpecular.xyz * u_xlat16_1.xxx + (-vec3(vec3(_Specular, _Specular, _Specular)));
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz + vec3(vec3(_Specular, _Specular, _Specular));
    u_xlat16_1.xyz = (bool(u_xlatb33)) ? u_xlat16_1.xyz : vec3(vec4(_Specular, _Specular, _Specular, _Specular));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_34 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_34 : u_xlat16_1.z;
    SV_Target2.xy = u_xlat16_1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISTANCEINVERT_ON" }
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
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat15;
float u_xlat18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat1.x;
    vs_TEXCOORD4.x = (-u_xlat1.x);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.yzw = u_xlat5.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat15) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _A;
uniform 	mediump float _G;
uniform 	mediump float _R;
uniform 	mediump float _B;
uniform 	vec4 _DiffuseArray_ST;
uniform 	mediump float _BContrast;
uniform 	mediump float _BStrength;
uniform 	vec4 _MaskArray_ST;
uniform 	mediump float _DistanceFadeEnable;
uniform 	mediump float _VertexMixDistance;
uniform 	mediump float _RIndex;
uniform 	mediump float _RContrast;
uniform 	mediump float _RStrength;
uniform 	mediump float _RTransparency;
uniform 	mediump float _GIndex;
uniform 	mediump float _GContrast;
uniform 	mediump float _GStrength;
uniform 	mediump float _GTransparency;
uniform 	mediump float _Range;
uniform 	mediump float _Specular;
uniform 	mediump vec4 _WetSpecular;
uniform 	vec4 _NormalArray_ST;
uniform 	mediump float _NormalScale;
uniform lowp sampler2DArray _DiffuseArray;
uniform lowp sampler2DArray _MaskArray;
uniform lowp sampler2DArray _NormalArray;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
bvec3 u_xlatb7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
mediump vec2 u_xlat16_24;
vec2 u_xlat27;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _VertexMixDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(_DistanceFadeEnable==1.0);
#else
    u_xlatb11 = _DistanceFadeEnable==1.0;
#endif
    u_xlat16_1.x = (u_xlatb11) ? u_xlat0.x : 0.0;
    u_xlat16_12 = u_xlat16_1.x + _RTransparency;
    u_xlat0.xyz = max(vs_COLOR0.zxy, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x * _BStrength;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_23 = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_1.x + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x + _GTransparency;
    u_xlat16_2.x = _BContrast * 2.0 + 1.0;
    u_xlat3.xy = vs_TEXCOORD3.xy * _MaskArray_ST.xy + _MaskArray_ST.zw;
    u_xlat4.zw = floor(vs_TEXCOORD3.wz);
    u_xlat3.zw = u_xlat4.zw;
    u_xlat10_5.xy = texture(_MaskArray, u_xlat3.xyw).xy;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat10_5.x);
    u_xlat16_23 = u_xlat16_23 + 2.0;
    u_xlat27.xy = texture(_MaskArray, u_xlat3.xyz).xy;
    u_xlat6.xy = u_xlat3.xy;
    u_xlat16_13 = u_xlat0.x * 2.0 + (-u_xlat27.x);
    u_xlat16_13 = u_xlat16_13 + 1.0;
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_13);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = u_xlat16_23 * u_xlat16_2.x + (-_BContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = (-u_xlat16_34) + u_xlat16_23;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_2.xy = (-u_xlat27.xy) + u_xlat10_5.xy;
    u_xlat16_2.xy = vec2(u_xlat16_23) * u_xlat16_2.xy + u_xlat27.xy;
    u_xlatb7.xyz = equal(vec4(_B, _R, _G, _B), vec4(1.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat16_2.xy = (u_xlatb7.x) ? u_xlat16_2.xy : u_xlat27.xy;
    u_xlat0.x = u_xlat0.y * _RStrength;
    u_xlat11 = u_xlat0.z * _GStrength;
    u_xlat0.y = exp2(u_xlat11);
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xy = min(u_xlat0.xy, vec2(1.0, 1.0));
    u_xlat16_34 = u_xlat0.x * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = (-u_xlat0.x) + 1.0;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat6.z = _RIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_24.x = (-u_xlat10_0.x) + u_xlat16_24.x;
    u_xlat16_8.xy = (-u_xlat16_2.xy) + u_xlat10_0.xz;
    u_xlat16_24.x = u_xlat16_24.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_24.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _RContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_RContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD3.xy * _NormalArray_ST.xy + _NormalArray_ST.zw;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyw).xyz;
    u_xlat10_5.xyz = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_23) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.x) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _RIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_12) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = (u_xlatb7.y) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat3.z = _GIndex;
    u_xlat10_0.xzw = texture(_NormalArray, u_xlat3.xyz).xyz;
    u_xlat16_10.xyz = u_xlat10_0.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10.xy = u_xlat16_10.xy * vec2(_NormalScale);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat16_34 = (-u_xlat0.y) + 1.0;
    u_xlat6.z = _GIndex;
    u_xlat10_0.xz = texture(_MaskArray, u_xlat6.xyz).xy;
    u_xlat16_34 = (-u_xlat10_0.x) + u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 + 2.0;
    u_xlat16_24.xy = vec2(u_xlat16_12) * u_xlat16_8.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.y) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_24.x = u_xlat0.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_24.x = u_xlat16_24.x + 1.0;
    u_xlat16_34 = u_xlat16_34 + (-u_xlat16_24.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_24.x = _GContrast * 2.0 + 1.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_24.x + (-_GContrast);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (u_xlatb7.z) ? u_xlat16_8.xyz : u_xlat16_9.xyz;
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat16_24.xy = u_xlat10_0.xz + (-u_xlat16_2.xy);
    u_xlat16_24.xy = u_xlat16_1.xx * u_xlat16_24.xy + u_xlat16_2.xy;
    u_xlat16_2.xy = (u_xlatb7.z) ? u_xlat16_24.xy : u_xlat16_2.xy;
    u_xlat16_34 = vs_COLOR0.w * 2.0 + (-u_xlat16_2.x);
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_2.x = (-vs_COLOR0.w) + _Range;
    u_xlat16_2.x = u_xlat16_2.x + 2.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_3.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(_A==1.0);
#else
    u_xlatb33 = _A==1.0;
#endif
    u_xlat16_2.xzw = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_8.xyz;
    u_xlat0.x = vs_TEXCOORD5.z;
    u_xlat0.y = vs_TEXCOORD6.z;
    u_xlat0.z = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD5.x;
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat16_8.xyz = u_xlat0.xyz * u_xlat3.yzx;
    u_xlat16_8.xyz = u_xlat0.zxy * u_xlat3.zxy + (-u_xlat16_8.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD5.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat16_9.xyz = u_xlat0.zxy * u_xlat5.yzx;
    u_xlat16_9.xyz = u_xlat5.xyz * u_xlat0.xyz + (-u_xlat16_9.xyz);
    u_xlat16_41 = dot(u_xlat3.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = float(1.0) / u_xlat16_41;
    u_xlat16_8.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz;
    u_xlat16_8.y = dot(u_xlat16_8.xyz, u_xlat16_2.xzw);
    u_xlat16_10.xyz = u_xlat3.zxy * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat3.yzx * u_xlat5.yzx + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_41) * u_xlat16_9.xyz;
    u_xlat16_8.x = dot(u_xlat16_9.xyz, u_xlat16_2.xzw);
    u_xlat16_8.z = dot(u_xlat16_10.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat4.xy = vs_TEXCOORD3.xy * _DiffuseArray_ST.xy + _DiffuseArray_ST.zw;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyw).xyz;
    u_xlat3.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_2.xzw = u_xlat10_0.xyz + (-u_xlat3.xyz);
    u_xlat16_2.xzw = vec3(u_xlat16_23) * u_xlat16_2.xzw + u_xlat3.xyz;
    u_xlat16_2.xzw = (u_xlatb7.x) ? u_xlat16_2.xzw : u_xlat3.xyz;
    u_xlat4.z = _RIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_2.xzw = (u_xlatb7.y) ? u_xlat16_8.xyz : u_xlat16_2.xzw;
    u_xlat4.z = _GIndex;
    u_xlat10_0.xyz = texture(_DiffuseArray, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xzw) + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz + u_xlat16_2.xzw;
    u_xlat16_1.xyz = (u_xlatb7.z) ? u_xlat16_1.xyz : u_xlat16_2.xzw;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = vec3(u_xlat16_34) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = (bool(u_xlatb33)) ? u_xlat0.xyz : u_xlat16_1.xyz;
    SV_Target1.w = 0.400000006;
    u_xlat16_0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat0.x = u_xlat16_34 * u_xlat16_0.x + u_xlat16_2.y;
    SV_Target2.w = (u_xlatb33) ? u_xlat0.x : u_xlat16_2.y;
    u_xlat0.x = dot(vs_TEXCOORD4.yzw, vs_TEXCOORD4.yzw);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = vec3(u_xlat0.x * vs_TEXCOORD4.y, u_xlat0.x * vs_TEXCOORD4.z, u_xlat0.x * vs_TEXCOORD4.w);
    u_xlat3.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x + 0.00999999978;
    u_xlat16_1.xyz = _WetSpecular.xyz * u_xlat16_1.xxx + (-vec3(vec3(_Specular, _Specular, _Specular)));
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz + vec3(vec3(_Specular, _Specular, _Specular));
    u_xlat16_1.xyz = (bool(u_xlatb33)) ? u_xlat16_1.xyz : vec3(vec4(_Specular, _Specular, _Specular, _Specular));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_34 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_34 : u_xlat16_1.z;
    SV_Target2.xy = u_xlat16_1.xy;
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
Keywords { "_DISTANCEINVERT_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISTANCEINVERT_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 91651
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
  GpuProgramID 142074
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
  Name "MOTIONVECTORS"
  Tags { "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 217596
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