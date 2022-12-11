//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/Cg_Ice_VertexOffset" {
Properties {
_Highlight_Color ("Highlight_Color", Color) = (0.7334559,0.8970082,0.9779412,1)
_Fresnal_Scale ("Fresnal_Scale", Float) = 6.97
_Fresnal_Power ("Fresnal_Power", Float) = 5.68
_IceLightColor ("IceLightColor", Color) = (0.5073529,0.9692103,1,1)
_IceDarkColor ("IceDarkColor", Color) = (0.1098039,0.1686275,0.172549,1)
_CubeMap ("CubeMap", Cube) = "white" { }
_CubeMapBrightness ("CubeMapBrightness", Float) = 1
_Matcap ("Matcap", 2D) = "white" { }
_MatCapSize ("MatCapSize", Range(0, 2)) = 1
_MatCapColor ("MatCapColor", Color) = (1,1,1,1)
_NormalMap ("NormalMap", 2D) = "white" { }
_NormalIntensity ("NormalIntensity", Color) = (1,1,0.916,1)
[Toggle(_GRADIENTCOLORTOGGLE_ON)] _GradientColorToggle ("GradientColorToggle", Float) = 0
_GradientColor ("GradientColor", Color) = (0.2352941,0.4304256,1,0)
_GradientRange ("GradientRange", Float) = 1
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_GradientOffset ("GradientOffset", Float) = 0
_DayColor ("DayColor", Color) = (1,1,1,1)
_AlphaBrightness ("AlphaBrightness", Float) = 1
_VertexMaskControl ("VertexMaskControl", Float) = 0.28
[Enum(X,0,Y,1,Z,2)] _VertexDirectionMask ("VertexDirectionMask", Float) = 2
_VertexMaskRange ("VertexMaskRange", Float) = 0
_VertexMaskSoft ("VertexMaskSoft", Float) = 0.3
_EdgeMask ("EdgeMask", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _EdgeMaskChannelSwitch ("EdgeMaskChannelSwitch", Float) = 0
_EdgeColor ("EdgeColor", Color) = (1,1,1,0)
_EdgeMapBrightness ("EdgeMapBrightness", Float) = 1
_EdgeRange ("EdgeRange", Float) = 0.18
_EdgeWidth ("EdgeWidth", Float) = 0.16
_EdgeMask_VSpeed ("EdgeMask_VSpeed", Float) = 0
_EdgeMask_USpeed ("EdgeMask_USpeed", Float) = 0
[Toggle(_VERTEXCOLORSWITCH_ON)] _VertexColorSwitch ("VertexColorSwitch", Float) = 0
_DistanceSphereCenter ("DistanceSphereCenter", Vector) = (0,0,0,0)
_Distance ("Distance", Float) = 0
_DistanceSphereRange ("DistanceSphereRange", Float) = 1
_DistancePow ("DistancePow", Float) = 1
_DistanceMaxRange ("DistanceMaxRange", Float) = 10
_Rotate ("Rotate", Float) = 0
[Header(Motion Vectors)] _MotionVectorsAlphaCutoff ("Motion Vectors Alpha Cutoff", Range(0, 1)) = 0.1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
}
SubShader {
 Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 60822
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_12.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat16_4.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump vec4 _MeshParticleColorArray;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MeshParticleColorArray.xyz + u_xlat16_12.xyz;
    u_xlat1.x = _DayColor.w * _MeshParticleColorArray.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat16_4.x * u_xlat1.x;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_12.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat16_4.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
struct miHoYoCGCg_Ice_VertexOffsetArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoCGCg_Ice_VertexOffset {
	miHoYoCGCg_Ice_VertexOffsetArray_Type miHoYoCGCg_Ice_VertexOffsetArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlati24 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = u_xlat0.xyz * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati24]._MeshParticleColorArray.xyz + u_xlat16_12.xyz;
    u_xlat0.x = _DayColor.w * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati24]._MeshParticleColorArray.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat16_4.x * u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
vec2 u_xlat12;
bvec3 u_xlatb12;
float u_xlat19;
float u_xlat21;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0 = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat10.xz = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat10.xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat19) + u_xlat1.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat19 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat19 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat19;
    u_xlat19 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat19;
    u_xlat19 = u_xlat19 + _VertexMaskControl;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat16_28 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat19 = u_xlat19 + (-_VertexMaskRange);
    u_xlat16_28 = float(1.0) / u_xlat16_28;
    u_xlat19 = u_xlat16_28 * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat3.x = u_xlat19 * u_xlat28;
    u_xlat12.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat12.xy = u_xlat12.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat12.xy);
    u_xlatb12.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 3.0)).xyz;
    u_xlat30 = u_xlatb12.z ? u_xlat4.w : float(0.0);
    u_xlat21 = (u_xlatb12.y) ? u_xlat4.z : u_xlat30;
    u_xlat12.x = (u_xlatb12.x) ? u_xlat4.y : u_xlat21;
    u_xlat12.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat12.x;
    u_xlat19 = u_xlat28 * u_xlat19 + u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Fresnal_Power;
    u_xlat27 = exp2(u_xlat27);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat27) + u_xlat0.xyz;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyw = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyw * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=_EdgeRange);
#else
    u_xlatb27 = u_xlat19>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb27) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=u_xlat16_8);
#else
    u_xlatb27 = u_xlat19>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb27) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_7.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat3.x, 1.0);
    u_xlat0.w = u_xlat1.x * u_xlat16_7.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump vec4 _MeshParticleColorArray;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
vec2 u_xlat12;
bvec3 u_xlatb12;
float u_xlat19;
float u_xlat21;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0 = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat10.xz = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat10.xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat19) + u_xlat1.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat19 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat19 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat19;
    u_xlat19 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat19;
    u_xlat19 = u_xlat19 + _VertexMaskControl;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat16_28 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat19 = u_xlat19 + (-_VertexMaskRange);
    u_xlat16_28 = float(1.0) / u_xlat16_28;
    u_xlat19 = u_xlat16_28 * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat3.x = u_xlat19 * u_xlat28;
    u_xlat12.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat12.xy = u_xlat12.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat12.xy);
    u_xlatb12.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 3.0)).xyz;
    u_xlat30 = u_xlatb12.z ? u_xlat4.w : float(0.0);
    u_xlat21 = (u_xlatb12.y) ? u_xlat4.z : u_xlat30;
    u_xlat12.x = (u_xlatb12.x) ? u_xlat4.y : u_xlat21;
    u_xlat12.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat12.x;
    u_xlat19 = u_xlat28 * u_xlat19 + u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Fresnal_Power;
    u_xlat27 = exp2(u_xlat27);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat27) + u_xlat0.xyz;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyw = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyw * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=_EdgeRange);
#else
    u_xlatb27 = u_xlat19>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb27) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=u_xlat16_8);
#else
    u_xlatb27 = u_xlat19>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb27) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MeshParticleColorArray.xyz + u_xlat16_7.xyz;
    u_xlat1.x = _DayColor.w * _MeshParticleColorArray.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat3.x, 1.0);
    u_xlat0.w = u_xlat1.x * u_xlat16_7.x;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
vec2 u_xlat12;
bvec3 u_xlatb12;
float u_xlat19;
float u_xlat21;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0 = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat10.xz = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat10.xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat19) + u_xlat1.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat19 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat19 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat19;
    u_xlat19 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat19;
    u_xlat19 = u_xlat19 + _VertexMaskControl;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat16_28 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat19 = u_xlat19 + (-_VertexMaskRange);
    u_xlat16_28 = float(1.0) / u_xlat16_28;
    u_xlat19 = u_xlat16_28 * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat3.x = u_xlat19 * u_xlat28;
    u_xlat12.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat12.xy = u_xlat12.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat12.xy);
    u_xlatb12.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 3.0)).xyz;
    u_xlat30 = u_xlatb12.z ? u_xlat4.w : float(0.0);
    u_xlat21 = (u_xlatb12.y) ? u_xlat4.z : u_xlat30;
    u_xlat12.x = (u_xlatb12.x) ? u_xlat4.y : u_xlat21;
    u_xlat12.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat12.x;
    u_xlat19 = u_xlat28 * u_xlat19 + u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Fresnal_Power;
    u_xlat27 = exp2(u_xlat27);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat27) + u_xlat0.xyz;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyw = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyw * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=_EdgeRange);
#else
    u_xlatb27 = u_xlat19>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb27) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=u_xlat16_8);
#else
    u_xlatb27 = u_xlat19>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb27) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_7.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat3.x, 1.0);
    u_xlat0.w = u_xlat1.x * u_xlat16_7.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
struct miHoYoCGCg_Ice_VertexOffsetArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoCGCg_Ice_VertexOffset {
	miHoYoCGCg_Ice_VertexOffsetArray_Type miHoYoCGCg_Ice_VertexOffsetArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
bvec3 u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat9;
lowp float u_xlat10_9;
vec3 u_xlat10;
float u_xlat12;
float u_xlat19;
vec2 u_xlat21;
float u_xlat28;
mediump float u_xlat16_34;
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
    u_xlat9.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat9.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat10.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat10.x = dot((-u_xlat9.xyz), u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat9.xyz = u_xlat4.xyz * (-u_xlat10.xxx) + (-u_xlat9.xyz);
    u_xlat10.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat9.xyz = u_xlat9.xyz * u_xlat10.xxx;
    u_xlat10_9 = texture(_CubeMap, u_xlat9.xyz).x;
    u_xlat9.x = u_xlat10_9 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat10.xx + u_xlat3.xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat28) + u_xlat10.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat28 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat28 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat28;
    u_xlat28 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat28;
    u_xlat28 = u_xlat28 + _VertexMaskControl;
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat16_3 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat28 = u_xlat28 + (-_VertexMaskRange);
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat28 = u_xlat28 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat12 = u_xlat28 * u_xlat3.x;
    u_xlat21.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat21.xy = u_xlat21.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat21.xy);
    u_xlatb5.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat21.x = u_xlatb5.z ? u_xlat4.w : float(0.0);
    u_xlat21.x = (u_xlatb5.y) ? u_xlat4.z : u_xlat21.x;
    u_xlat21.x = (u_xlatb5.x) ? u_xlat4.y : u_xlat21.x;
    u_xlat21.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat21.x;
    u_xlat28 = u_xlat3.x * u_xlat28 + u_xlat21.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat9.xyz = _Highlight_Color.xyz * u_xlat1.xxx + u_xlat9.xyz;
    u_xlat1.xy = u_xlat10.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat9.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat28>=_EdgeRange);
#else
    u_xlatb1 = u_xlat28>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat28>=u_xlat16_8);
#else
    u_xlatb1 = u_xlat28>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb1) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat9.xyz * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati0]._MeshParticleColorArray.xyz + u_xlat16_7.xyz;
    u_xlat0 = _DayColor.w * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat0 = u_xlat0 * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat12, 1.0);
    u_xlat1.w = u_xlat0 * u_xlat16_7.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_12.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat16_4.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump vec4 _MeshParticleColorArray;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MeshParticleColorArray.xyz + u_xlat16_12.xyz;
    u_xlat1.x = _DayColor.w * _MeshParticleColorArray.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat16_4.x * u_xlat1.x;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_12.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat0.w = u_xlat16_4.x * u_xlat1.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
struct miHoYoCGCg_Ice_VertexOffsetArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoCGCg_Ice_VertexOffset {
	miHoYoCGCg_Ice_VertexOffsetArray_Type miHoYoCGCg_Ice_VertexOffsetArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
bvec3 u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_20;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
void main()
{
    u_xlat0.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_3.xyz = texture(_NormalMap, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _NormalIntensity.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = vec2(u_xlat25) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = dot(u_xlat6.xyz, u_xlat16_4.xyz);
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat24) + u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat5.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat5.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_1 = texture(_CubeMap, u_xlat1.xyz).x;
    u_xlat1.x = u_xlat10_1 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + _IceDarkColor.xyz;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat24 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _Fresnal_Power;
    u_xlat24 = exp2(u_xlat24);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlatb1 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat24 = u_xlatb1.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat24 = (u_xlatb1.y) ? vs_TEXCOORD8.y : u_xlat24;
    u_xlat24 = (u_xlatb1.x) ? vs_TEXCOORD8.x : u_xlat24;
    u_xlat24 = u_xlat24 + _VertexMaskControl;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 + (-_VertexMaskRange);
    u_xlat16_1 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_1 = float(1.0) / u_xlat16_1;
    u_xlat24 = u_xlat24 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat24 * -2.0 + 3.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat9.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat2.x = _Time.y * _EdgeMask_USpeed;
    u_xlat2.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat9.xy = u_xlat9.xy + u_xlat2.xy;
    u_xlat2 = texture(_EdgeMask, u_xlat9.xy);
    u_xlatb3.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat9.x = u_xlatb3.z ? u_xlat2.w : float(0.0);
    u_xlat9.x = (u_xlatb3.y) ? u_xlat2.z : u_xlat9.x;
    u_xlat9.x = (u_xlatb3.x) ? u_xlat2.y : u_xlat9.x;
    u_xlat9.x = (u_xlatb1.w) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.x = u_xlat1.x * u_xlat24 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat16_4.x = min(u_xlat24, 1.0);
    u_xlat16_12.x = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat9.x>=u_xlat16_12.x);
#else
    u_xlatb24 = u_xlat9.x>=u_xlat16_12.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat9.x>=_EdgeRange);
#else
    u_xlatb1.x = u_xlat9.x>=_EdgeRange;
#endif
    u_xlat16_12.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_20 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_12.x = u_xlat16_20 + u_xlat16_12.x;
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
    u_xlat16_12.xyz = u_xlat16_12.xxx * u_xlat16_7.xyz;
    u_xlati24 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = u_xlat0.xyz * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati24]._MeshParticleColorArray.xyz + u_xlat16_12.xyz;
    u_xlat0.x = _DayColor.w * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati24]._MeshParticleColorArray.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat16_4.x * u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
vec2 u_xlat12;
bvec3 u_xlatb12;
float u_xlat19;
float u_xlat21;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0 = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat10.xz = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat10.xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat19) + u_xlat1.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat19 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat19 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat19;
    u_xlat19 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat19;
    u_xlat19 = u_xlat19 + _VertexMaskControl;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat16_28 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat19 = u_xlat19 + (-_VertexMaskRange);
    u_xlat16_28 = float(1.0) / u_xlat16_28;
    u_xlat19 = u_xlat16_28 * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat3.x = u_xlat19 * u_xlat28;
    u_xlat12.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat12.xy = u_xlat12.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat12.xy);
    u_xlatb12.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 3.0)).xyz;
    u_xlat30 = u_xlatb12.z ? u_xlat4.w : float(0.0);
    u_xlat21 = (u_xlatb12.y) ? u_xlat4.z : u_xlat30;
    u_xlat12.x = (u_xlatb12.x) ? u_xlat4.y : u_xlat21;
    u_xlat12.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat12.x;
    u_xlat19 = u_xlat28 * u_xlat19 + u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Fresnal_Power;
    u_xlat27 = exp2(u_xlat27);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat27) + u_xlat0.xyz;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyw = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyw * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=_EdgeRange);
#else
    u_xlatb27 = u_xlat19>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb27) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=u_xlat16_8);
#else
    u_xlatb27 = u_xlat19>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb27) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_7.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat3.x, 1.0);
    u_xlat0.w = u_xlat1.x * u_xlat16_7.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    vs_TEXCOORD4.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump vec4 _MeshParticleColorArray;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
vec2 u_xlat12;
bvec3 u_xlatb12;
float u_xlat19;
float u_xlat21;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0 = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat10.xz = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat10.xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat19) + u_xlat1.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat19 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat19 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat19;
    u_xlat19 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat19;
    u_xlat19 = u_xlat19 + _VertexMaskControl;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat16_28 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat19 = u_xlat19 + (-_VertexMaskRange);
    u_xlat16_28 = float(1.0) / u_xlat16_28;
    u_xlat19 = u_xlat16_28 * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat3.x = u_xlat19 * u_xlat28;
    u_xlat12.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat12.xy = u_xlat12.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat12.xy);
    u_xlatb12.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 3.0)).xyz;
    u_xlat30 = u_xlatb12.z ? u_xlat4.w : float(0.0);
    u_xlat21 = (u_xlatb12.y) ? u_xlat4.z : u_xlat30;
    u_xlat12.x = (u_xlatb12.x) ? u_xlat4.y : u_xlat21;
    u_xlat12.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat12.x;
    u_xlat19 = u_xlat28 * u_xlat19 + u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Fresnal_Power;
    u_xlat27 = exp2(u_xlat27);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat27) + u_xlat0.xyz;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyw = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyw * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=_EdgeRange);
#else
    u_xlatb27 = u_xlat19>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb27) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=u_xlat16_8);
#else
    u_xlatb27 = u_xlat19>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb27) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MeshParticleColorArray.xyz + u_xlat16_7.xyz;
    u_xlat1.x = _DayColor.w * _MeshParticleColorArray.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat3.x, 1.0);
    u_xlat0.w = u_xlat1.x * u_xlat16_7.x;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
vec2 u_xlat12;
bvec3 u_xlatb12;
float u_xlat19;
float u_xlat21;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_34;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat1.x = dot((-u_xlat0.xyz), u_xlat4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat0.xyz = u_xlat4.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_0 = texture(_CubeMap, u_xlat0.xyz).x;
    u_xlat0.x = u_xlat10_0 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat10.x = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat10.xz = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat1.xx + u_xlat10.xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat19) + u_xlat1.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat19 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat19 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat19;
    u_xlat19 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat19;
    u_xlat19 = u_xlat19 + _VertexMaskControl;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat16_28 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat19 = u_xlat19 + (-_VertexMaskRange);
    u_xlat16_28 = float(1.0) / u_xlat16_28;
    u_xlat19 = u_xlat16_28 * u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat3.x = u_xlat19 * u_xlat28;
    u_xlat12.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat12.xy = u_xlat12.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat12.xy);
    u_xlatb12.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 3.0)).xyz;
    u_xlat30 = u_xlatb12.z ? u_xlat4.w : float(0.0);
    u_xlat21 = (u_xlatb12.y) ? u_xlat4.z : u_xlat30;
    u_xlat12.x = (u_xlatb12.x) ? u_xlat4.y : u_xlat21;
    u_xlat12.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat12.x;
    u_xlat19 = u_xlat28 * u_xlat19 + u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 9.99999975e-05);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Fresnal_Power;
    u_xlat27 = exp2(u_xlat27);
    u_xlat0.xyz = _Highlight_Color.xyz * vec3(u_xlat27) + u_xlat0.xyz;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyw = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyw * _MatCapColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=_EdgeRange);
#else
    u_xlatb27 = u_xlat19>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb27) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat19>=u_xlat16_8);
#else
    u_xlatb27 = u_xlat19>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb27) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat16_7.xyz;
    u_xlat1.x = vs_COLOR0.w * _DayColor.w;
    u_xlat1.x = u_xlat1.x * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat3.x, 1.0);
    u_xlat0.w = u_xlat1.x * u_xlat16_7.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3.x = sin(u_xlat16_2.x);
    u_xlat4.x = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4.x) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4.x;
    u_xlat13.xyz = u_xlat16_2.xyz * u_xlat3.xxx;
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + u_xlat4.xx;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat27 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8 = in_POSITION0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _Highlight_Color;
uniform 	vec4 _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _CubeMapBrightness;
uniform 	float _MatCapSize;
uniform 	mediump vec4 _MatCapColor;
uniform 	vec4 _DayColor;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeMapBrightness;
uniform 	mediump float _EdgeRange;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump float _EdgeMaskChannelSwitch;
uniform 	mediump float _EdgeMask_USpeed;
uniform 	mediump float _EdgeMask_VSpeed;
uniform 	vec4 _EdgeMask_ST;
uniform 	mediump float _EdgeWidth;
uniform 	mediump float _AlphaBrightness;
struct miHoYoCGCg_Ice_VertexOffsetArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoCGCg_Ice_VertexOffset {
	miHoYoCGCg_Ice_VertexOffsetArray_Type miHoYoCGCg_Ice_VertexOffsetArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _EdgeMask;
uniform lowp sampler2D _Matcap;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
bvec3 u_xlatb5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat9;
lowp float u_xlat10_9;
vec3 u_xlat10;
float u_xlat12;
float u_xlat19;
vec2 u_xlat21;
float u_xlat28;
mediump float u_xlat16_34;
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
    u_xlat9.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _NormalIntensity.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat5.x = vs_TEXCOORD5.y;
    u_xlat5.y = vs_TEXCOORD7.y;
    u_xlat5.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat9.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat10.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat10.x = dot((-u_xlat9.xyz), u_xlat4.xyz);
    u_xlat10.x = u_xlat10.x + u_xlat10.x;
    u_xlat9.xyz = u_xlat4.xyz * (-u_xlat10.xxx) + (-u_xlat9.xyz);
    u_xlat10.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat9.xyz = u_xlat9.xyz * u_xlat10.xxx;
    u_xlat10_9 = texture(_CubeMap, u_xlat9.xyz).x;
    u_xlat9.x = u_xlat10_9 * _CubeMapBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat10.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat10.xyz + _IceDarkColor.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat19 = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat3.xy = vec2(u_xlat19) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat10.xx + u_xlat3.xy;
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat28) + u_xlat10.xy;
    u_xlatb2 = equal(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _EdgeMaskChannelSwitch), vec4(0.0, 1.0, 2.0, 0.0));
    u_xlat28 = u_xlatb2.z ? vs_TEXCOORD8.z : float(0.0);
    u_xlat28 = (u_xlatb2.y) ? vs_TEXCOORD8.y : u_xlat28;
    u_xlat28 = (u_xlatb2.x) ? vs_TEXCOORD8.x : u_xlat28;
    u_xlat28 = u_xlat28 + _VertexMaskControl;
    u_xlat28 = (-u_xlat28) + 1.0;
    u_xlat16_3 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat28 = u_xlat28 + (-_VertexMaskRange);
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat28 = u_xlat28 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat28 * -2.0 + 3.0;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat12 = u_xlat28 * u_xlat3.x;
    u_xlat21.xy = vs_TEXCOORD0.xy * _EdgeMask_ST.xy + _EdgeMask_ST.zw;
    u_xlat4.x = _Time.y * _EdgeMask_USpeed;
    u_xlat4.y = _Time.y * _EdgeMask_VSpeed;
    u_xlat21.xy = u_xlat21.xy + u_xlat4.xy;
    u_xlat4 = texture(_EdgeMask, u_xlat21.xy);
    u_xlatb5.xyz = equal(vec4(vec4(_EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch, _EdgeMaskChannelSwitch)), vec4(1.0, 2.0, 3.0, 0.0)).xyz;
    u_xlat21.x = u_xlatb5.z ? u_xlat4.w : float(0.0);
    u_xlat21.x = (u_xlatb5.y) ? u_xlat4.z : u_xlat21.x;
    u_xlat21.x = (u_xlatb5.x) ? u_xlat4.y : u_xlat21.x;
    u_xlat21.x = (u_xlatb2.w) ? u_xlat4.x : u_xlat21.x;
    u_xlat28 = u_xlat3.x * u_xlat28 + u_xlat21.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat9.xyz = _Highlight_Color.xyz * u_xlat1.xxx + u_xlat9.xyz;
    u_xlat1.xy = u_xlat10.xy * vec2(vec2(_MatCapSize, _MatCapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture(_Matcap, u_xlat1.xy).xyz;
    u_xlat9.xyz = u_xlat10_1.xyz * _MatCapColor.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _DayColor.xyz;
    u_xlat16_7.xyz = _EdgeColor.xyz * vec3(_EdgeMapBrightness);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat28>=_EdgeRange);
#else
    u_xlatb1 = u_xlat28>=_EdgeRange;
#endif
    u_xlat16_34 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_8 = _EdgeRange + _EdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat28>=u_xlat16_8);
#else
    u_xlatb1 = u_xlat28>=u_xlat16_8;
#endif
    u_xlat16_8 = (u_xlatb1) ? -1.0 : -0.0;
    u_xlat16_34 = u_xlat16_34 + u_xlat16_8;
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_34) * u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat9.xyz * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati0]._MeshParticleColorArray.xyz + u_xlat16_7.xyz;
    u_xlat0 = _DayColor.w * miHoYoCGCg_Ice_VertexOffsetArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat0 = u_xlat0 * _AlphaBrightness;
    u_xlat16_7.x = min(u_xlat12, 1.0);
    u_xlat1.w = u_xlat0 * u_xlat16_7.x;
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
Keywords { "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 109662
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3 = sin(u_xlat16_2.x);
    u_xlat4 = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4;
    u_xlat13.xyz = u_xlat16_2.xyz * vec3(u_xlat3);
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + vec2(u_xlat4);
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    SV_Target0 = vec4(0.497999996, 0.497999996, 0.0, 1.0);
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
uniform 	mediump float _MHYZBias;
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3 = sin(u_xlat16_2.x);
    u_xlat4 = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4;
    u_xlat13.xyz = u_xlat16_2.xyz * vec3(u_xlat3);
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + vec2(u_xlat4);
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.497999996, 0.497999996, 0.0, 1.0);
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
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 154616
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3 = sin(u_xlat16_2.x);
    u_xlat4 = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4;
    u_xlat13.xyz = u_xlat16_2.xyz * vec3(u_xlat3);
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + vec2(u_xlat4);
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat3 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec3 u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlatb0.xyz = equal(vec4(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb0.z ? vs_TEXCOORD5.z : float(0.0);
    u_xlat3 = (u_xlatb0.y) ? vs_TEXCOORD5.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb0.x) ? vs_TEXCOORD5.x : u_xlat3;
    u_xlat0.x = u_xlat0.x + _VertexMaskControl;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x + (-_VertexMaskRange);
    u_xlat16_3 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat0.x = vs_COLOR0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb0.x = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3 = sin(u_xlat16_2.x);
    u_xlat4 = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4;
    u_xlat13.xyz = u_xlat16_2.xyz * vec3(u_xlat3);
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + vec2(u_xlat4);
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat3 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
uniform 	mediump vec4 _MeshParticleColorArray;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec3 u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlatb0.xyz = equal(vec4(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb0.z ? vs_TEXCOORD5.z : float(0.0);
    u_xlat3 = (u_xlatb0.y) ? vs_TEXCOORD5.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb0.x) ? vs_TEXCOORD5.x : u_xlat3;
    u_xlat0.x = u_xlat0.x + _VertexMaskControl;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x + (-_VertexMaskRange);
    u_xlat16_3 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat0.x = _DayColor.w * _MeshParticleColorArray.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb0.x = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
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
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3 = sin(u_xlat16_2.x);
    u_xlat4 = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4;
    u_xlat13.xyz = u_xlat16_2.xyz * vec3(u_xlat3);
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + vec2(u_xlat4);
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat3 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec3 u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlatb0.xyz = equal(vec4(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb0.z ? vs_TEXCOORD5.z : float(0.0);
    u_xlat3 = (u_xlatb0.y) ? vs_TEXCOORD5.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb0.x) ? vs_TEXCOORD5.x : u_xlat3;
    u_xlat0.x = u_xlat0.x + _VertexMaskControl;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x + (-_VertexMaskRange);
    u_xlat16_3 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat0.x = vs_COLOR0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb0.x = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _Rotate;
uniform 	mediump vec3 _DistanceSphereCenter;
uniform 	mediump float _DistanceSphereRange;
uniform 	mediump float _Distance;
uniform 	mediump float _DistancePow;
uniform 	mediump float _DistanceMaxRange;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat27;
int u_xlati27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = in_COLOR0.xyz * vec3(-1.0, 1.0, 1.0) + vec3(0.5, -0.5, -0.5);
    u_xlat16_1.xyz = u_xlat0.xyz + (-_DistanceSphereCenter.xyz);
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_28);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_1.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_28 = u_xlat16_2.x * _DistanceSphereRange + (-_Distance);
    u_xlat16_28 = max(u_xlat16_28, 9.99999975e-05);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _DistancePow;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = min(u_xlat16_28, _DistanceMaxRange);
    u_xlat16_2.x = u_xlat16_28 * _Rotate;
    u_xlat3 = sin(u_xlat16_2.x);
    u_xlat4 = cos(u_xlat16_2.x);
    u_xlat27 = (-u_xlat4) + 1.0;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat12.xyz = in_COLOR0.zxy * vec3(1.0, -1.0, 1.0) + vec3(-0.5, 0.5, -0.5);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat12.xyz;
    u_xlat12.xyz = vec3(u_xlat27) * u_xlat16_2.yzx;
    u_xlat5.w = u_xlat12.z * u_xlat16_2.x + u_xlat4;
    u_xlat13.xyz = u_xlat16_2.xyz * vec3(u_xlat3);
    u_xlat6.xy = u_xlat12.xy * u_xlat16_2.yz + vec2(u_xlat4);
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + u_xlat13.y;
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.zx + (-u_xlat13.xz);
    u_xlat7.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    u_xlat8.z = dot(u_xlat5.yzw, u_xlat7.xyz);
    u_xlat6.z = u_xlat5.x;
    u_xlat5.z = u_xlat12.y * u_xlat16_2.x + (-u_xlat13.y);
    u_xlat5.xy = u_xlat12.xx * u_xlat16_2.xz + u_xlat13.zx;
    u_xlat5.w = u_xlat6.y;
    u_xlat8.y = dot(u_xlat5.ywz, u_xlat7.xyz);
    u_xlat6.w = u_xlat5.x;
    u_xlat8.x = dot(u_xlat6.xzw, u_xlat7.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati27 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati27 = u_xlati27 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati27 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat3 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat3 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	mediump float _AlphaBrightness;
uniform 	mediump float _VertexMaskRange;
uniform 	mediump float _VertexMaskSoft;
uniform 	mediump float _VertexDirectionMask;
uniform 	mediump float _VertexMaskControl;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec3 u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlatb0.xyz = equal(vec4(vec4(_VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask, _VertexDirectionMask)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb0.z ? vs_TEXCOORD5.z : float(0.0);
    u_xlat3 = (u_xlatb0.y) ? vs_TEXCOORD5.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb0.x) ? vs_TEXCOORD5.x : u_xlat3;
    u_xlat0.x = u_xlat0.x + _VertexMaskControl;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x + (-_VertexMaskRange);
    u_xlat16_3 = (-_VertexMaskRange) + _VertexMaskSoft;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat0.x = u_xlat16_3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = _DayColor.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb0.x = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
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
Keywords { "_VERTEXCOLORSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_VERTEXCOLORSWITCH_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}