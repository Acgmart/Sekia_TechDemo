//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Particle_IceSurface" {
Properties {
_CubeMap ("Cube Map", Cube) = "white" { }
_CubeMapInstensity ("Cube Map Instensity", Range(0, 10)) = 0.07
_CubeMask ("Cube Mask", 2D) = "white" { }
_CubeMaskUVscale ("Cube Mask UV scale", Range(0, 2)) = 1
_CubeMaskScaler ("Cube Mask Scaler", Range(0, 1)) = 1
_IceDarkColor ("IceDarkColor", Color) = (0.1098039,0.1686275,0.172549,0)
_IceLightColor ("IceLightColor", Color) = (0.5073529,0.9692103,1,0)
_IceBumpTex ("IceBumpTex", 2D) = "white" { }
_BumpOffsetHeight ("BumpOffsetHeight", Float) = 14.89
_BumpTexIntensity ("BumpTexIntensity", Range(0, 2)) = 1
_NormalTex ("Normal Tex", 2D) = "bump" { }
_NormalUVScale ("Normal UV Scale", Range(0, 2)) = 1
_NormalScale ("Normal Scale", Float) = 3
_IcePatternColor01 ("IcePatternColor01", Color) = (0.75,0.75,0.75,1)
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_IcePatternColor02 ("IcePatternColor02", Color) = (0.75,0.75,0.75,1)
_IcePattern01Intensity ("IcePattern01Intensity", Range(0, 2)) = 0
_IcePatternTex ("IcePatternTex", 2D) = "white" { }
_IcePatternUVScale ("IcePatternUVScale", Range(0, 2)) = 0.3
_DissMap ("DissMap", 2D) = "white" { }
[Enum(R,0,G,1,B,2)] _MaskChannel ("MaskChannel", Float) = 0
_Diss ("Diss", Range(0, 1)) = 1
_Brightness ("Brightness", Float) = 1
_Opacity ("Opacity", Float) = 1
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
  GpuProgramID 58062
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
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
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat9;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD9.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.y;
    u_xlat2.y = vs_TEXCOORD8.y;
    u_xlat2.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.z;
    u_xlat2.y = vs_TEXCOORD8.z;
    u_xlat2.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat12 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * vs_TEXCOORD5.xy;
    u_xlat12 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat9.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat9.xy;
    u_xlat10_12 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat12 = u_xlat10_12 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_CubeMaskUVscale);
    u_xlat10_12 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat12 = u_xlat10_12 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_3.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xyz = texture(_DissMap, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = vs_COLOR0.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
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
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xzy;
    u_xlat3.y = u_xlat2.z;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat6.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = u_xlat6.x;
    u_xlat5.z = u_xlat1.x;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xzy;
    u_xlat2.x = u_xlat6.z;
    vs_TEXCOORD6.xyz = u_xlat6.xyz;
    u_xlat2.z = u_xlat1.z;
    vs_TEXCOORD7.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * u_xlat4.zzz + u_xlat3.xyz;
    vs_TEXCOORD9.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
struct miHoYoParticlesParticle_IceSurfaceArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesParticle_IceSurface {
	miHoYoParticlesParticle_IceSurfaceArray_Type miHoYoParticlesParticle_IceSurfaceArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
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
int u_xlati0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat9;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD9.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.y;
    u_xlat2.y = vs_TEXCOORD8.y;
    u_xlat2.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.z;
    u_xlat2.y = vs_TEXCOORD8.z;
    u_xlat2.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat12 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * vs_TEXCOORD5.xy;
    u_xlat12 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat9.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat9.xy;
    u_xlat10_12 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat12 = u_xlat10_12 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_CubeMaskUVscale);
    u_xlat10_12 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat12 = u_xlat10_12 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_3.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesParticle_IceSurfaceArray[u_xlati0]._MeshParticleColorArray;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xyz = texture(_DissMap, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat0.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(_IcePatternUVScale);
    u_xlat10_0.xy = texture(_IcePatternTex, u_xlat0.xy).xy;
    u_xlat12.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * vs_TEXCOORD5.xy;
    u_xlat13 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13);
    u_xlat12.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat12.xy;
    u_xlat10_12 = texture(_IceBumpTex, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat12.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat12.xy = u_xlat12.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat12.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat2.xyz = u_xlat12.xxx * vs_TEXCOORD9.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat12.x = dot((-u_xlat2.xyz), u_xlat4.xyz);
    u_xlat12.x = u_xlat12.x + u_xlat12.x;
    u_xlat2.xyz = u_xlat4.xyz * (-u_xlat12.xxx) + (-u_xlat2.xyz);
    u_xlat12.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat10_2.xyz = texture(_CubeMap, u_xlat2.xyz).xyz;
    u_xlat12.xy = u_xlat12.xy * vec2(_CubeMaskUVscale);
    u_xlat10_12 = texture(_CubeMask, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 * _CubeMaskScaler;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.x = u_xlat10_0.y * _IcePattern01Intensity;
    u_xlat6.xyz = (-u_xlat1.xyz) + _IcePatternColor02.xyz;
    u_xlat6.xyz = u_xlat16_3.xxx * u_xlat6.xyz + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat1.xyz = texture(_DissMap, u_xlat1.xy).xyz;
    u_xlatb2.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : 0.0;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.xyz = _IcePatternColor01.xyz * u_xlat10_0.xxx + u_xlat6.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = vs_COLOR0.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
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
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xzy;
    u_xlat3.y = u_xlat2.z;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat6.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = u_xlat6.x;
    u_xlat5.z = u_xlat1.x;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xzy;
    u_xlat2.x = u_xlat6.z;
    vs_TEXCOORD6.xyz = u_xlat6.xyz;
    u_xlat2.z = u_xlat1.z;
    vs_TEXCOORD7.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * u_xlat4.zzz + u_xlat3.xyz;
    vs_TEXCOORD9.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
struct miHoYoParticlesParticle_IceSurfaceArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesParticle_IceSurface {
	miHoYoParticlesParticle_IceSurfaceArray_Type miHoYoParticlesParticle_IceSurfaceArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
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
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
mediump vec3 u_xlat16_9;
vec2 u_xlat13;
float u_xlat18;
lowp float u_xlat10_18;
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
    u_xlat6.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat6.xy = u_xlat6.xy * vec2(_IcePatternUVScale);
    u_xlat10_6.xy = texture(_IcePatternTex, u_xlat6.xy).xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat13.xy = vec2(u_xlat18) * vs_TEXCOORD5.xy;
    u_xlat18 = _BumpOffsetHeight + -1.0;
    u_xlat13.xy = u_xlat13.xy * vec2(u_xlat18);
    u_xlat1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_18 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat18 = dot((-u_xlat2.xyz), u_xlat4.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat4.xyz * (-vec3(u_xlat18)) + (-u_xlat2.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat10_2.xyz = texture(_CubeMap, u_xlat2.xyz).xyz;
    u_xlat4.xy = u_xlat4.xy * vec2(_CubeMaskUVscale);
    u_xlat10_18 = texture(_CubeMask, u_xlat4.xy).x;
    u_xlat18 = u_xlat10_18 * _CubeMaskScaler;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.x = u_xlat10_6.y * _IcePattern01Intensity;
    u_xlat2.xyz = (-u_xlat1.xyz) + _IcePatternColor02.xyz;
    u_xlat1.xyz = u_xlat16_3.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesParticle_IceSurfaceArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xzw = texture(_DissMap, u_xlat0.xz).xyz;
    u_xlatb4.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb4.z) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb4.y) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb4.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_9.xyz = _IcePatternColor01.xyz * u_xlat10_6.xxx + u_xlat1.xyz;
    u_xlat16_9.xyz = u_xlat2.xyz * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat2.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
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
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat9;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD9.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.y;
    u_xlat2.y = vs_TEXCOORD8.y;
    u_xlat2.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.z;
    u_xlat2.y = vs_TEXCOORD8.z;
    u_xlat2.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat12 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * vs_TEXCOORD5.xy;
    u_xlat12 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat9.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat9.xy;
    u_xlat10_12 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat12 = u_xlat10_12 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_CubeMaskUVscale);
    u_xlat10_12 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat12 = u_xlat10_12 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_3.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xyz = texture(_DissMap, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = vs_COLOR0.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
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
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xzy;
    u_xlat3.y = u_xlat2.z;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat6.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = u_xlat6.x;
    u_xlat5.z = u_xlat1.x;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xzy;
    u_xlat2.x = u_xlat6.z;
    vs_TEXCOORD6.xyz = u_xlat6.xyz;
    u_xlat2.z = u_xlat1.z;
    vs_TEXCOORD7.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * u_xlat4.zzz + u_xlat3.xyz;
    vs_TEXCOORD9.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
struct miHoYoParticlesParticle_IceSurfaceArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesParticle_IceSurface {
	miHoYoParticlesParticle_IceSurfaceArray_Type miHoYoParticlesParticle_IceSurfaceArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
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
int u_xlati0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat9;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD9.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.y;
    u_xlat2.y = vs_TEXCOORD8.y;
    u_xlat2.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD6.z;
    u_xlat2.y = vs_TEXCOORD8.z;
    u_xlat2.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat12 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
    u_xlat10_0.xyz = texture(_CubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * vs_TEXCOORD5.xy;
    u_xlat12 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat9.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat9.xy;
    u_xlat10_12 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat12 = u_xlat10_12 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_CubeMaskUVscale);
    u_xlat10_12 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat12 = u_xlat10_12 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_3.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesParticle_IceSurfaceArray[u_xlati0]._MeshParticleColorArray;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xyz = texture(_DissMap, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat0.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD8.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD9.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bvec3 u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(_IcePatternUVScale);
    u_xlat10_0.xy = texture(_IcePatternTex, u_xlat0.xy).xy;
    u_xlat12.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * vs_TEXCOORD5.xy;
    u_xlat13 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat13);
    u_xlat12.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat12.xy;
    u_xlat10_12 = texture(_IceBumpTex, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat12.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat12.xy = u_xlat12.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat12.x = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat2.xyz = u_xlat12.xxx * vs_TEXCOORD9.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat12.x = dot((-u_xlat2.xyz), u_xlat4.xyz);
    u_xlat12.x = u_xlat12.x + u_xlat12.x;
    u_xlat2.xyz = u_xlat4.xyz * (-u_xlat12.xxx) + (-u_xlat2.xyz);
    u_xlat12.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat10_2.xyz = texture(_CubeMap, u_xlat2.xyz).xyz;
    u_xlat12.xy = u_xlat12.xy * vec2(_CubeMaskUVscale);
    u_xlat10_12 = texture(_CubeMask, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 * _CubeMaskScaler;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.x = u_xlat10_0.y * _IcePattern01Intensity;
    u_xlat6.xyz = (-u_xlat1.xyz) + _IcePatternColor02.xyz;
    u_xlat6.xyz = u_xlat16_3.xxx * u_xlat6.xyz + u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat1.xyz = texture(_DissMap, u_xlat1.xy).xyz;
    u_xlatb2.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb2.z) ? u_xlat1.z : 0.0;
    u_xlat16_3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat16_3.x;
    u_xlat16_9.xyz = _IcePatternColor01.xyz * u_xlat10_0.xxx + u_xlat6.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = vs_COLOR0.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
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
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat6.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat6.yzx * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat6.zxy + (-u_xlat2.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xzy;
    u_xlat3.y = u_xlat2.z;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat6.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = u_xlat6.x;
    u_xlat5.z = u_xlat1.x;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xzy;
    u_xlat2.x = u_xlat6.z;
    vs_TEXCOORD6.xyz = u_xlat6.xyz;
    u_xlat2.z = u_xlat1.z;
    vs_TEXCOORD7.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz * u_xlat4.zzz + u_xlat3.xyz;
    vs_TEXCOORD9.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	vec4 _IcePatternTex_ST;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	vec4 _IceBumpTex_ST;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	float _NormalScale;
uniform 	vec4 _NormalTex_ST;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	vec4 _CubeMask_ST;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _Brightness;
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
struct miHoYoParticlesParticle_IceSurfaceArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesParticle_IceSurface {
	miHoYoParticlesParticle_IceSurfaceArray_Type miHoYoParticlesParticle_IceSurfaceArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
uniform lowp sampler2D _DissMap;
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
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec3 u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
mediump vec3 u_xlat16_9;
vec2 u_xlat13;
float u_xlat18;
lowp float u_xlat10_18;
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
    u_xlat6.xy = vs_TEXCOORD0.xy * _IcePatternTex_ST.xy + _IcePatternTex_ST.zw;
    u_xlat6.xy = u_xlat6.xy * vec2(_IcePatternUVScale);
    u_xlat10_6.xy = texture(_IcePatternTex, u_xlat6.xy).xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _IceBumpTex_ST.xy + _IceBumpTex_ST.zw;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat13.xy = vec2(u_xlat18) * vs_TEXCOORD5.xy;
    u_xlat18 = _BumpOffsetHeight + -1.0;
    u_xlat13.xy = u_xlat13.xy * vec2(u_xlat18);
    u_xlat1.xy = u_xlat13.xy * vec2(0.100000001, 0.100000001) + u_xlat1.xy;
    u_xlat10_18 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_18 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(_NormalUVScale);
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat18 = dot(vs_TEXCOORD9.xyz, vs_TEXCOORD9.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD9.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat18 = dot((-u_xlat2.xyz), u_xlat4.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat2.xyz = u_xlat4.xyz * (-vec3(u_xlat18)) + (-u_xlat2.xyz);
    u_xlat4.xy = vs_TEXCOORD0.xy * _CubeMask_ST.xy + _CubeMask_ST.zw;
    u_xlat10_2.xyz = texture(_CubeMap, u_xlat2.xyz).xyz;
    u_xlat4.xy = u_xlat4.xy * vec2(_CubeMaskUVscale);
    u_xlat10_18 = texture(_CubeMask, u_xlat4.xy).x;
    u_xlat18 = u_xlat10_18 * _CubeMaskScaler;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_CubeMapInstensity, _CubeMapInstensity, _CubeMapInstensity)) + (-u_xlat1.xyz);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.x = u_xlat10_6.y * _IcePattern01Intensity;
    u_xlat2.xyz = (-u_xlat1.xyz) + _IcePatternColor02.xyz;
    u_xlat1.xyz = u_xlat16_3.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesParticle_IceSurfaceArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xzw = texture(_DissMap, u_xlat0.xz).xyz;
    u_xlatb4.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_3.x = (u_xlatb4.z) ? u_xlat0.w : 0.0;
    u_xlat16_3.x = (u_xlatb4.y) ? u_xlat0.z : u_xlat16_3.x;
    u_xlat16_3.x = (u_xlatb4.x) ? u_xlat0.x : u_xlat16_3.x;
    u_xlat16_9.xyz = _IcePatternColor01.xyz * u_xlat10_6.xxx + u_xlat1.xyz;
    u_xlat16_9.xyz = u_xlat2.xyz * u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat2.w * _Diss + (-u_xlat16_3.x);
    SV_Target0.w = u_xlat16_3.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 127703
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
  GpuProgramID 135658
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _DissMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
ivec2 u_xlati1;
bvec3 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xyz = texture(_DissMap, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat16_2 = vs_COLOR0.w * _Diss + (-u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_2 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump float _Diss;
uniform 	mediump float _MaskChannel;
uniform 	vec4 _DissMap_ST;
uniform 	mediump float _Opacity;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DissMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
ivec2 u_xlati1;
bvec3 u_xlatb1;
mediump float u_xlat16_2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissMap_ST.xy + _DissMap_ST.zw;
    u_xlat0.xyz = texture(_DissMap, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati0]._MeshParticleColorArray.w;
    u_xlat16_2 = u_xlat0.x * _Diss + (-u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _Opacity;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_2 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
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
Keywords { "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}