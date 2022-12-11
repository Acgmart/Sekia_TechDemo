//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/ElementBaseModel/ElementModel_Billboard" {
Properties {
_OnlyVertexColor ("OnlyVertexColor", Range(0, 1)) = 0
_ColorScale ("ColorScale", Float) = 1
_AlphaScale ("AlphaScale", Range(0, 1)) = 1
_ElementColorTex ("ElementColorTex", 2D) = "white" { }
_ElementMask ("ElementMask", 2D) = "white" { }
_MaskChannelNum ("MaskChannelNum", Range(0, 3)) = 1
_DistortTex ("DistortTex", 2D) = "white" { }
_DistortTexPanner ("DistortTexPanner", Vector) = (0,0,0,0)
_DistortScale ("DistortScale", Range(0, 1)) = 0
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
  GpuProgramID 12923
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortTex, u_xlat0.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(_DistortScale) + u_xlat6.xy;
    u_xlat10_0.xyz = texture(_ElementColorTex, u_xlat6.xy).xyz;
    u_xlat10_2.xyz = texture(_ElementMask, u_xlat16_1.xy).xyz;
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xz = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_9 = u_xlat16_5.z + u_xlat16_5.x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_9;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_1.w + u_xlat16_9;
    u_xlat16_1.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 + u_xlat16_1.x;
    u_xlat9 = u_xlat16_9 * vs_COLOR0.w;
    u_xlat9 = u_xlat9 * _AlphaScale;
    SV_Target0.w = u_xlat9;
    u_xlat2.xyz = (-u_xlat10_0.xyz) + vs_COLOR0.xyz;
    u_xlat0.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
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
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortTex, u_xlat0.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(_DistortScale) + u_xlat6.xy;
    u_xlat10_0.xyz = texture(_ElementColorTex, u_xlat6.xy).xyz;
    u_xlat10_2.xyz = texture(_ElementMask, u_xlat16_1.xy).xyz;
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xz = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_9 = u_xlat16_5.z + u_xlat16_5.x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_9;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_1.w + u_xlat16_9;
    u_xlat16_1.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 + u_xlat16_1.x;
    u_xlat9 = u_xlat16_9 * vs_COLOR0.w;
    u_xlat9 = u_xlat9 * _AlphaScale;
    SV_Target0.w = u_xlat9;
    u_xlat2.xyz = (-u_xlat10_0.xyz) + vs_COLOR0.xyz;
    u_xlat0.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat10_1.xyz = texture(_ElementColorTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = (-u_xlat10_1.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_1.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat8.xy;
    u_xlat10_8.xy = texture(_DistortTex, u_xlat8.xy).xy;
    u_xlat16_3.xy = u_xlat10_8.xy * vec2(_DistortScale) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_ElementMask, u_xlat16_3.xy).xyz;
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
    u_xlat16_4.xz = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_4.x = u_xlat16_4.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_0 = u_xlat16_3.x + u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat10_1.xyz = texture(_ElementColorTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = (-u_xlat10_1.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_1.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat8.xy;
    u_xlat10_8.xy = texture(_DistortTex, u_xlat8.xy).xy;
    u_xlat16_3.xy = u_xlat10_8.xy * vec2(_DistortScale) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_ElementMask, u_xlat16_3.xy).xyz;
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
    u_xlat16_4.xz = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_4.x = u_xlat16_4.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_0 = u_xlat16_3.x + u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortTex, u_xlat0.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(_DistortScale) + u_xlat6.xy;
    u_xlat10_0.xyz = texture(_ElementColorTex, u_xlat6.xy).xyz;
    u_xlat10_2.xyz = texture(_ElementMask, u_xlat16_1.xy).xyz;
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xz = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_9 = u_xlat16_5.z + u_xlat16_5.x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_9;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_1.w + u_xlat16_9;
    u_xlat16_1.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 + u_xlat16_1.x;
    u_xlat9 = u_xlat16_9 * vs_COLOR0.w;
    u_xlat9 = u_xlat9 * _AlphaScale;
    SV_Target0.w = u_xlat9;
    u_xlat2.xyz = (-u_xlat10_0.xyz) + vs_COLOR0.xyz;
    u_xlat0.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortTex, u_xlat0.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(_DistortScale) + u_xlat6.xy;
    u_xlat10_0.xyz = texture(_ElementColorTex, u_xlat6.xy).xyz;
    u_xlat10_2.xyz = texture(_ElementMask, u_xlat16_1.xy).xyz;
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_5.xz = u_xlat16_1.xy * u_xlat10_2.xy;
    u_xlat16_9 = u_xlat16_5.z + u_xlat16_5.x;
    u_xlat16_9 = u_xlat10_2.z * u_xlat16_1.z + u_xlat16_9;
    u_xlat16_9 = u_xlat10_2.x * u_xlat16_1.w + u_xlat16_9;
    u_xlat16_1.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 + u_xlat16_1.x;
    u_xlat9 = u_xlat16_9 * vs_COLOR0.w;
    u_xlat9 = u_xlat9 * _AlphaScale;
    SV_Target0.w = u_xlat9;
    u_xlat2.xyz = (-u_xlat10_0.xyz) + vs_COLOR0.xyz;
    u_xlat0.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat10_1.xyz = texture(_ElementColorTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = (-u_xlat10_1.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_1.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat8.xy;
    u_xlat10_8.xy = texture(_DistortTex, u_xlat8.xy).xy;
    u_xlat16_3.xy = u_xlat10_8.xy * vec2(_DistortScale) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_ElementMask, u_xlat16_3.xy).xyz;
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
    u_xlat16_4.xz = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_4.x = u_xlat16_4.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_0 = u_xlat16_3.x + u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ColorScale;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump float _OnlyVertexColor;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _ElementColorTex;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat8;
lowp vec2 u_xlat10_8;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat10_1.xyz = texture(_ElementColorTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = (-u_xlat10_1.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = vec3(_OnlyVertexColor) * u_xlat2.xyz + u_xlat10_1.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * vec2(_DistortTexPanner.x, _DistortTexPanner.y) + u_xlat8.xy;
    u_xlat10_8.xy = texture(_DistortTex, u_xlat8.xy).xy;
    u_xlat16_3.xy = u_xlat10_8.xy * vec2(_DistortScale) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_ElementMask, u_xlat16_3.xy).xyz;
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_ColorScale, _ColorScale, _ColorScale));
    u_xlat16_4.xz = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_4.x = u_xlat16_4.z + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_4.x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_0 = u_xlat16_3.x + u_xlat16_0;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _AlphaScale;
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
  GpuProgramID 128197
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
  GpuProgramID 152449
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
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
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortTex, u_xlat0.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(_DistortScale) + u_xlat6.xy;
    u_xlat10_0.xyz = texture(_ElementMask, u_xlat16_1.xy).xyz;
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_3.x = u_xlat16_3.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat0.x * _AlphaScale + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _ElementColorTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _ElementMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortTex, u_xlat0.xy).xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _ElementColorTex_ST.xy + _ElementColorTex_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(_DistortScale) + u_xlat6.xy;
    u_xlat10_0.xyz = texture(_ElementMask, u_xlat16_1.xy).xyz;
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_3.x = u_xlat16_3.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_3.x;
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_1.w + u_xlat16_3.x;
    u_xlat16_1.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1.x;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.w;
    u_xlat16_1.x = u_xlat0.x * _AlphaScale + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
Keywords { "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}