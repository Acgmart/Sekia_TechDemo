//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Lottery_SkyBox" {
Properties {
_PaletterMap ("PaletterMap", 2D) = "white" { }
_ColorSpeed ("ColorSpeed", Float) = 0
_Desaturate ("Desaturate", Range(0, 1)) = 0
_Mask ("Mask", 2D) = "white" { }
_StarMap01 ("StarMap01", 2D) = "white" { }
_StarTiling02 ("StarTiling02", Vector) = (1,1,0,0)
_StarBrightness01 ("StarBrightness01", Float) = 1
_StarBrightness02 ("StarBrightness02", Float) = 1
_StarOffset01 ("StarOffset01", Float) = 0
_StarOffset02 ("StarOffset02", Float) = 0
_StarMaskUVmove ("StarMaskUVmove", Float) = 0
_GradientRange ("GradientRange", Float) = 8
_GradientOffset ("GradientOffset", Float) = -6
_StarColorMap ("StarColorMap", 2D) = "white" { }
_texcoord ("", 2D) = "white" { }
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
  GpuProgramID 23921
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD5.xy;
    u_xlat16_1.x = _StarOffset02 + -1.0;
    u_xlat10.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(0.300000012, 0.300000012) + u_xlat2.xy;
    u_xlat10_10 = texture(_StarMap01, u_xlat10.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_15 = texture(_Mask, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_10 * u_xlat10_15;
    u_xlat16_10 = u_xlat16_10 * _StarBrightness02;
    u_xlat16_1.x = _StarOffset01 + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(0.200000003, 0.200000003) + u_xlat2.xy;
    u_xlat10_0 = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_15 * u_xlat10_0;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat10_2.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat5.xz = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_3.xyz = texture(_StarColorMap, u_xlat5.xz).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_1.xyz;
    u_xlat5.x = _Time.y * _ColorSpeed;
    u_xlat5.xz = u_xlat5.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_2.xyz = texture(_PaletterMap, u_xlat5.xz).xyz;
    u_xlat16_5 = dot(u_xlat10_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat16_5);
    u_xlat16_4.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat15 + (-u_xlat2.x);
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + u_xlat16_4.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD5.xy;
    u_xlat16_1.x = _StarOffset02 + -1.0;
    u_xlat10.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(0.300000012, 0.300000012) + u_xlat2.xy;
    u_xlat10_10 = texture(_StarMap01, u_xlat10.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_15 = texture(_Mask, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_10 * u_xlat10_15;
    u_xlat16_10 = u_xlat16_10 * _StarBrightness02;
    u_xlat16_1.x = _StarOffset01 + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(0.200000003, 0.200000003) + u_xlat2.xy;
    u_xlat10_0 = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_15 * u_xlat10_0;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat10_2.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat5.xz = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_3.xyz = texture(_StarColorMap, u_xlat5.xz).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_1.xyz;
    u_xlat5.x = _Time.y * _ColorSpeed;
    u_xlat5.xz = u_xlat5.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_2.xyz = texture(_PaletterMap, u_xlat5.xz).xyz;
    u_xlat16_5 = dot(u_xlat10_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat16_5);
    u_xlat16_4.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat15 + (-u_xlat2.x);
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + u_xlat16_4.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_5;
lowp float u_xlat10_5;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
vec2 u_xlat10;
float u_xlat15;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _ColorSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_PaletterMap, u_xlat0.xy).xyz;
    u_xlat16_15 = dot(u_xlat10_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_15);
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat10.xx * vs_TEXCOORD5.xy;
    u_xlat16_16 = _StarOffset01 + -1.0;
    u_xlat2.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat0.xy = u_xlat2.xy * vec2(0.200000003, 0.200000003) + u_xlat0.xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask, u_xlat2.xy).x;
    u_xlat7.xy = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_7.xyz = texture(_StarColorMap, u_xlat7.xy).xyz;
    u_xlat10_0.x = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_2 * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat16_16 = _StarOffset02 + -1.0;
    u_xlat5.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat5.xy = u_xlat5.xy * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat10_5 = texture(_StarMap01, u_xlat5.xy).x;
    u_xlat16_5 = u_xlat10_5 * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * _StarBrightness02;
    u_xlat10_3.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat10.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat15 * u_xlat2.x + u_xlat10.x;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat10_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyw = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat10.xxx * u_xlat16_0.xyw + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_5;
lowp float u_xlat10_5;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
vec2 u_xlat10;
float u_xlat15;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _ColorSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_PaletterMap, u_xlat0.xy).xyz;
    u_xlat16_15 = dot(u_xlat10_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_15);
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat10.xx * vs_TEXCOORD5.xy;
    u_xlat16_16 = _StarOffset01 + -1.0;
    u_xlat2.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat0.xy = u_xlat2.xy * vec2(0.200000003, 0.200000003) + u_xlat0.xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask, u_xlat2.xy).x;
    u_xlat7.xy = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_7.xyz = texture(_StarColorMap, u_xlat7.xy).xyz;
    u_xlat10_0.x = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_2 * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat16_16 = _StarOffset02 + -1.0;
    u_xlat5.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat5.xy = u_xlat5.xy * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat10_5 = texture(_StarMap01, u_xlat5.xy).x;
    u_xlat16_5 = u_xlat10_5 * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * _StarBrightness02;
    u_xlat10_3.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat10.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat15 * u_xlat2.x + u_xlat10.x;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat10_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyw = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat10.xxx * u_xlat16_0.xyw + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD5.xy;
    u_xlat16_1.x = _StarOffset02 + -1.0;
    u_xlat10.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(0.300000012, 0.300000012) + u_xlat2.xy;
    u_xlat10_10 = texture(_StarMap01, u_xlat10.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_15 = texture(_Mask, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_10 * u_xlat10_15;
    u_xlat16_10 = u_xlat16_10 * _StarBrightness02;
    u_xlat16_1.x = _StarOffset01 + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(0.200000003, 0.200000003) + u_xlat2.xy;
    u_xlat10_0 = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_15 * u_xlat10_0;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat10_2.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat5.xz = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_3.xyz = texture(_StarColorMap, u_xlat5.xz).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_1.xyz;
    u_xlat5.x = _Time.y * _ColorSpeed;
    u_xlat5.xz = u_xlat5.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_2.xyz = texture(_PaletterMap, u_xlat5.xz).xyz;
    u_xlat16_5 = dot(u_xlat10_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat16_5);
    u_xlat16_4.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat15 + (-u_xlat2.x);
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + u_xlat16_4.xyz;
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
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
float u_xlat7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD5.xy;
    u_xlat16_1.x = _StarOffset02 + -1.0;
    u_xlat10.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(0.300000012, 0.300000012) + u_xlat2.xy;
    u_xlat10_10 = texture(_StarMap01, u_xlat10.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_15 = texture(_Mask, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_10 * u_xlat10_15;
    u_xlat16_10 = u_xlat16_10 * _StarBrightness02;
    u_xlat16_1.x = _StarOffset01 + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(0.200000003, 0.200000003) + u_xlat2.xy;
    u_xlat10_0 = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_15 * u_xlat10_0;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat10_2.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat5.xz = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_3.xyz = texture(_StarColorMap, u_xlat5.xz).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_1.xyz;
    u_xlat5.x = _Time.y * _ColorSpeed;
    u_xlat5.xz = u_xlat5.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_2.xyz = texture(_PaletterMap, u_xlat5.xz).xyz;
    u_xlat16_5 = dot(u_xlat10_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_4.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat16_5);
    u_xlat16_4.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_10) * u_xlat10_3.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat15 + (-u_xlat2.x);
    u_xlat15 = u_xlat15 * u_xlat7 + u_xlat2.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + u_xlat16_4.xyz;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_5;
lowp float u_xlat10_5;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
vec2 u_xlat10;
float u_xlat15;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _ColorSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_PaletterMap, u_xlat0.xy).xyz;
    u_xlat16_15 = dot(u_xlat10_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_15);
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat10.xx * vs_TEXCOORD5.xy;
    u_xlat16_16 = _StarOffset01 + -1.0;
    u_xlat2.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat0.xy = u_xlat2.xy * vec2(0.200000003, 0.200000003) + u_xlat0.xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask, u_xlat2.xy).x;
    u_xlat7.xy = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_7.xyz = texture(_StarColorMap, u_xlat7.xy).xyz;
    u_xlat10_0.x = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_2 * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat16_16 = _StarOffset02 + -1.0;
    u_xlat5.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat5.xy = u_xlat5.xy * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat10_5 = texture(_StarMap01, u_xlat5.xy).x;
    u_xlat16_5 = u_xlat10_5 * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * _StarBrightness02;
    u_xlat10_3.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat10.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat15 * u_xlat2.x + u_xlat10.x;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat10_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyw = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat10.xxx * u_xlat16_0.xyw + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ColorSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarOffset01;
uniform 	mediump float _StarMaskUVmove;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _StarBrightness01;
uniform 	vec4 _StarColorMap_ST;
uniform 	mediump vec2 _StarTiling02;
uniform 	mediump float _StarOffset02;
uniform 	mediump float _StarBrightness02;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform lowp sampler2D _PaletterMap;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _StarColorMap;
uniform lowp sampler2D _StarMap01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_5;
lowp float u_xlat10_5;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
vec2 u_xlat10;
float u_xlat15;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _ColorSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_PaletterMap, u_xlat0.xy).xyz;
    u_xlat16_15 = dot(u_xlat10_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_15);
    u_xlat16_1.xyz = vec3(vec3(_Desaturate, _Desaturate, _Desaturate)) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xy = u_xlat10.xx * vs_TEXCOORD5.xy;
    u_xlat16_16 = _StarOffset01 + -1.0;
    u_xlat2.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat0.xy = u_xlat2.xy * vec2(0.200000003, 0.200000003) + u_xlat0.xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(vec2(_StarMaskUVmove, _StarMaskUVmove)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask, u_xlat2.xy).x;
    u_xlat7.xy = vs_TEXCOORD0.xy * _StarColorMap_ST.xy + _StarColorMap_ST.zw;
    u_xlat10_7.xyz = texture(_StarColorMap, u_xlat7.xy).xyz;
    u_xlat10_0.x = texture(_StarMap01, u_xlat0.xy).y;
    u_xlat16_0.x = u_xlat10_2 * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _StarBrightness01;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTiling02.xy;
    u_xlat16_16 = _StarOffset02 + -1.0;
    u_xlat5.xy = u_xlat10.xy * vec2(u_xlat16_16);
    u_xlat5.xy = u_xlat5.xy * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat10_5 = texture(_StarMap01, u_xlat5.xy).x;
    u_xlat16_5 = u_xlat10_5 * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * _StarBrightness02;
    u_xlat10_3.xyz = texture(_PaletterMap, vs_TEXCOORD1.xy).xyz;
    u_xlat10.x = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat15 = _GradientOffset + _GradientRange;
    u_xlat15 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat15 * u_xlat2.x + u_xlat10.x;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat10_7.xyz + u_xlat10_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_5) * u_xlat10_7.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyw = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat10.xxx * u_xlat16_0.xyw + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
  GpuProgramID 96263
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
  GpuProgramID 187333
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
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-_MotionVectorsAlphaCutoff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    u_xlati7.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat1.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat1.xy = sqrt(abs(u_xlat1.xy));
    u_xlati7.xy = (-u_xlati7.xy) + u_xlati2.xy;
    u_xlat7.xy = vec2(u_xlati7.xy);
    u_xlat1.xy = u_xlat7.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat1.xy;
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

precision highp int;
uniform 	mediump float _MotionVectorsAlphaCutoff;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec2 u_xlat1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-_MotionVectorsAlphaCutoff) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    u_xlati7.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat1.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat1.xy = sqrt(abs(u_xlat1.xy));
    u_xlati7.xy = (-u_xlati7.xy) + u_xlati2.xy;
    u_xlat7.xy = vec2(u_xlati7.xy);
    u_xlat1.xy = u_xlat7.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat1.xy;
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