//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UnityBuiltin/Window" {
Properties {
_OpacityMask ("Opacity Mask", 2D) = "white" { }
_Color1 ("Color 1", Color) = (0,0,0,0)
_Spe ("Spe", Float) = 0
_Gloss ("Gloss", Range(0, 500)) = 0
_NVint ("N.V int", Float) = 0
_NVfalloff ("N.V falloff", Float) = 0
_TextureSample5 ("Texture Sample 5", Cube) = "white" { }
_TextureSample6 ("Texture Sample 6", Cube) = "white" { }
_Float0 ("Float 0", Range(-10, 10)) = 0
_cubeoffet ("cube offet", Range(0, 1)) = 0
_cubeint ("cube int", Range(0, 1)) = 0
_noisetiling ("noise tiling", Float) = 11
_noisescale ("noise scale", Float) = 0
_TextureSample3 ("Texture Sample 3", 2D) = "bump" { }
_TextureSample1 ("Texture Sample 1", 2D) = "white" { }
_Float1 ("Float 1", Float) = 0
_Opacityplus ("Opacity plus", Range(0, 1)) = 0
_Opacity ("Opacity", Float) = 0
_tiling ("tiling", Float) = 0
_bias ("bias", Float) = 0
_scale ("scale", Float) = 0
_BlurOffset ("BlurOffset", Float) = 1
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
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 51994
Program "vp" {
SubProgram "gles3 " {
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
vec3 u_xlat7;
float u_xlat24;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat7.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec2 u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat17;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec2 u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
vec3 u_xlat7;
float u_xlat24;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat7.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
float u_xlat27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_28;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat17;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
float u_xlat27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
vec3 u_xlat7;
float u_xlat24;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat7.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec2 u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat17;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec2 u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
vec3 u_xlat7;
float u_xlat24;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat7.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
float u_xlat27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat17;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
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
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
float u_xlat27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_28;
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
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat6.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
float u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat21;
bool u_xlatb21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat1.x = u_xlat21 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_23 = (u_xlatb21) ? u_xlat1.x : 1.0;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat1.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat1.x * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat8.x : 1.0;
    u_xlat1.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_3.x;
    u_xlat1.x = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat1.x) + 2.0;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat16_3.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat1.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat1.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat21 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat7.x) + 2.0;
    u_xlat16_23 = u_xlat7.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat7.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0 = u_xlat8.xxxx * u_xlat0;
    u_xlat8.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat8.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat7.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat0.yzw;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat27 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5.x : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat17;
    u_xlat3.xyz = u_xlat5.xxx * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
float u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat21;
bool u_xlatb21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat1.x = u_xlat21 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_23 = (u_xlatb21) ? u_xlat1.x : 1.0;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat1.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat1.x * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat8.x : 1.0;
    u_xlat1.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_3.x;
    u_xlat1.x = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat1.x) + 2.0;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat16_3.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat1.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat1.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat21 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat7.x) + 2.0;
    u_xlat16_23 = u_xlat7.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat7.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0 = u_xlat8.xxxx * u_xlat0;
    u_xlat8.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat8.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat7.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat0.yzw;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat6.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
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
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat15;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat9.y = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat12 * u_xlat3.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!((-u_xlat27)>=u_xlat12);
#else
    u_xlatb27 = (-u_xlat27)>=u_xlat12;
#endif
    u_xlat12 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat27 = (u_xlatb27) ? u_xlat12 : u_xlat3.x;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * unity_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat3.x) + 2.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat30 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat6.xyz + u_xlat3.xyz;
    u_xlat30 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat15 = u_xlat30 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat30 = u_xlat15 / u_xlat30;
    u_xlat16_2.x = (u_xlatb6) ? u_xlat30 : 1.0;
    u_xlat9.x = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat6.x = u_xlat9.x * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat9.x = u_xlat6.x / u_xlat9.x;
    u_xlat16_2.y = (u_xlatb30) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_2.xy = u_xlat9.yx * u_xlat16_2.xy;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_2.y));
    u_xlat16_2.y = (-u_xlat16_11) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat9.x = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = u_xlat9.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat27) + 1.0;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_28;
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
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat27 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5.x : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat17;
    u_xlat3.xyz = u_xlat5.xxx * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
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
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat15;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat9.y = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat12 * u_xlat3.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!((-u_xlat27)>=u_xlat12);
#else
    u_xlatb27 = (-u_xlat27)>=u_xlat12;
#endif
    u_xlat12 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat27 = (u_xlatb27) ? u_xlat12 : u_xlat3.x;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * unity_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat3.x) + 2.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat30 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat6.xyz + u_xlat3.xyz;
    u_xlat30 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat15 = u_xlat30 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat30 = u_xlat15 / u_xlat30;
    u_xlat16_2.x = (u_xlatb6) ? u_xlat30 : 1.0;
    u_xlat9.x = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat6.x = u_xlat9.x * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat9.x = u_xlat6.x / u_xlat9.x;
    u_xlat16_2.y = (u_xlatb30) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_2.xy = u_xlat9.yx * u_xlat16_2.xy;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_2.y));
    u_xlat16_2.y = (-u_xlat16_11) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat9.x = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = u_xlat9.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat27) + 1.0;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
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
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat6.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
float u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat21;
bool u_xlatb21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat1.x = u_xlat21 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_23 = (u_xlatb21) ? u_xlat1.x : 1.0;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat1.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat1.x * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat8.x : 1.0;
    u_xlat1.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_3.x;
    u_xlat1.x = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat1.x) + 2.0;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat16_3.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat1.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat1.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat21 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat7.x) + 2.0;
    u_xlat16_23 = u_xlat7.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat7.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0 = u_xlat8.xxxx * u_xlat0;
    u_xlat8.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat8.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat7.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat0.yzw;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
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
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat27 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5.x : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat17;
    u_xlat3.xyz = u_xlat5.xxx * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
vec3 u_xlat8;
float u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat21;
bool u_xlatb21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = vs_TEXCOORD7.x;
    u_xlat0.y = vs_TEXCOORD8.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_1.xyz = texture(_TextureSample1, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.y;
    u_xlat0.y = vs_TEXCOORD8.y;
    u_xlat0.z = vs_TEXCOORD5.y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = vs_TEXCOORD7.z;
    u_xlat0.y = vs_TEXCOORD8.z;
    u_xlat0.z = vs_TEXCOORD5.z;
    u_xlat16_3.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat16_3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_3.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_1.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat4.xyz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = max(u_xlat16_1.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat21 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * _ES_SunDirection.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat6.xy = u_xlat5.xy;
    u_xlat6.z = (-u_xlat5.z);
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat7.x = max(u_xlat7.x, 9.99999975e-05);
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Gloss;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Spe;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 16.0);
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat7.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_7.xyz = texture(_OpacityMask, u_xlat7.xy).xyz;
    u_xlat16_7.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.x = dot(u_xlat16_7.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat16_2.x = u_xlat16_2.x / vs_TEXCOORD4.w;
    u_xlat4.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_4.xy = texture(_TextureSample3, u_xlat4.xy, _bias).xy;
    u_xlat16_16.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_2.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat16_2.xy;
    u_xlat10_4.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_2.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat5.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat5.xy = u_xlat16_16.xy * vec2(_scale) + u_xlat5.xy;
    u_xlat10_5.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat5.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * vec3(_Opacity);
    u_xlat16_3.xyz = (-vec3(_Opacity)) * u_xlat16_7.xyz + vec3(_Float1);
    u_xlat16_2.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat16_7.xyz = (-u_xlat16_2.xyz) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.w = u_xlat16_2.x;
    u_xlat16_2.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat1.x = u_xlat21 * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_23 = (u_xlatb21) ? u_xlat1.x : 1.0;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat1.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat1.x * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat8.x : 1.0;
    u_xlat1.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_3.x;
    u_xlat1.x = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat1.x) + 2.0;
    u_xlat16_3.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat16_3.x * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_23 = u_xlat1.x * u_xlat16_23;
    u_xlat1.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat1.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat21 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat21 * u_xlat7.x;
    u_xlat21 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat21 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat7.x) + 2.0;
    u_xlat16_23 = u_xlat7.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat7.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0 = u_xlat8.xxxx * u_xlat0;
    u_xlat8.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat8.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat7.xyz = u_xlat8.xyz * u_xlat1.xxx + u_xlat0.yzw;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
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
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat6.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
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
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat15;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat9.y = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat12 * u_xlat3.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!((-u_xlat27)>=u_xlat12);
#else
    u_xlatb27 = (-u_xlat27)>=u_xlat12;
#endif
    u_xlat12 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat27 = (u_xlatb27) ? u_xlat12 : u_xlat3.x;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * unity_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat3.x) + 2.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat30 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat6.xyz + u_xlat3.xyz;
    u_xlat30 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat15 = u_xlat30 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat30 = u_xlat15 / u_xlat30;
    u_xlat16_2.x = (u_xlatb6) ? u_xlat30 : 1.0;
    u_xlat9.x = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat6.x = u_xlat9.x * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat9.x = u_xlat6.x / u_xlat9.x;
    u_xlat16_2.y = (u_xlatb30) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_2.xy = u_xlat9.yx * u_xlat16_2.xy;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_2.y));
    u_xlat16_2.y = (-u_xlat16_11) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat9.x = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = u_xlat9.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat27) + 1.0;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_28;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
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
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5.x = u_xlat27 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5.x : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5.x = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5.x * u_xlat17;
    u_xlat3.xyz = u_xlat5.xxx * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD9.xyz = u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    vs_TEXCOORD6.xyz = u_xlat8.xxx * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	mediump float _Opacity;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _Float1;
uniform 	mediump float _Opacityplus;
uniform 	mediump vec4 _Color1;
uniform 	mediump float _scale;
uniform 	mediump float _tiling;
uniform 	mediump float _bias;
uniform 	mediump float _BlurOffset;
uniform 	mediump float _Spe;
uniform 	vec3 _ES_SunDirection;
uniform 	mediump float _Gloss;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _noisescale;
uniform 	mediump float _noisetiling;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _Float0;
uniform 	mediump float _cubeint;
uniform lowp sampler2D _OpacityMask;
uniform lowp sampler2D _TextureSample3;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _TextureSample1;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
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
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat15;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_0.xyz = texture(_OpacityMask, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Opacity);
    u_xlat16_2.xyz = (-vec3(_Opacity)) * u_xlat16_0.xyz + vec3(_Float1);
    u_xlat16_1.xyz = vec3(vec3(_Opacityplus, _Opacityplus, _Opacityplus)) * u_xlat16_2.xyz + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_28 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = (-_LightColor0.xyz) + _Color1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.649999976, 0.649999976, 0.649999976) + _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * vec2(vec2(_tiling, _tiling));
    u_xlat10_3.xy = texture(_TextureSample3, u_xlat3.xy, _bias).xy;
    u_xlat16_4.xy = u_xlat10_3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_29 = _BlurOffset * 0.00999999978 + vs_TEXCOORD4.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat3.xy).xyz;
    u_xlat16_5.x = u_xlat16_29 / vs_TEXCOORD4.w;
    u_xlat16_5.y = vs_TEXCOORD4.y / vs_TEXCOORD4.w;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(_scale) + u_xlat16_5.xy;
    u_xlat10_6.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_4.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(_ES_SunDirection.xyz, _ES_SunDirection.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.xyz = vec3(u_xlat27) * _ES_SunDirection.xyz;
    u_xlat8.xy = u_xlat6.xy;
    u_xlat8.z = (-u_xlat6.z);
    u_xlat27 = dot(u_xlat8.xyz, u_xlat7.xyz);
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Gloss;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _Spe;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 16.0);
    u_xlat30 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * vs_TEXCOORD6.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat16_1.x = dot(u_xlat16_0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat0.x = (-u_xlat30) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat27;
    u_xlat0.x = (-u_xlat16_1.x) + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD3.xy * vec2(_noisetiling);
    u_xlat10_9.xyz = texture(_TextureSample1, u_xlat9.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_9.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(vec2(_noisescale, _noisescale));
    u_xlat6.x = vs_TEXCOORD7.x;
    u_xlat6.y = vs_TEXCOORD8.x;
    u_xlat6.z = vs_TEXCOORD5.x;
    u_xlat16_2.x = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD5.y;
    u_xlat16_2.y = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat6.x = vs_TEXCOORD7.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD5.z;
    u_xlat16_2.z = dot(u_xlat6.xyz, u_xlat16_1.xyz);
    u_xlat9.x = dot((-u_xlat7.xyz), u_xlat16_2.xyz);
    u_xlat9.x = u_xlat9.x + u_xlat9.x;
    u_xlat9.xyz = u_xlat16_2.xyz * (-u_xlat9.xxx) + (-u_xlat7.xyz);
    u_xlat30 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = u_xlat9.xyz * vec3(u_xlat30);
    u_xlat16_1.xyz = u_xlat9.xyz * vec3(u_xlat30) + vec3(0.00700000022, 0.00700000022, 0.00700000022);
    u_xlat10_9.xyz = texture(_TextureSample6, u_xlat16_1.xyz).xyz;
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat6.xyz).xyz;
    u_xlat16_6.xyz = (-u_xlat10_9.xyz) + u_xlat10_6.xyz;
    u_xlat16_9.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_6.xyz + u_xlat10_9.xyz;
    u_xlat16_1.xyz = max(u_xlat16_9.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Float0, _Float0, _Float0));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_9.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD9.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat9.y = u_xlat0.x * _HeigtFogParams.y;
    u_xlat3.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat3.x) + 2.0;
    u_xlat3.x = u_xlat12 * u_xlat3.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!((-u_xlat27)>=u_xlat12);
#else
    u_xlatb27 = (-u_xlat27)>=u_xlat12;
#endif
    u_xlat12 = u_xlat3.x * _HeigtFogColDelta.w;
    u_xlat27 = (u_xlatb27) ? u_xlat12 : u_xlat3.x;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * unity_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat3.x = vs_TEXCOORD9.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat3.x) + 2.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat30 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat6.xyz + u_xlat3.xyz;
    u_xlat30 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat30));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat30);
#endif
    u_xlat15 = u_xlat30 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat30 = u_xlat15 / u_xlat30;
    u_xlat16_2.x = (u_xlatb6) ? u_xlat30 : 1.0;
    u_xlat9.x = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb30 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat6.x = u_xlat9.x * -1.44269502;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat9.x = u_xlat6.x / u_xlat9.x;
    u_xlat16_2.y = (u_xlatb30) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_2.xy = u_xlat9.yx * u_xlat16_2.xy;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_2.y));
    u_xlat16_2.y = (-u_xlat16_11) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD9.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat9.x = (-u_xlat0.x) + 1.0;
    u_xlat3.xyz = u_xlat9.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat27) + 1.0;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_28;
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
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}