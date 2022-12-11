//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/Galaxy" {
Properties {
_FadeValue ("FadeValue", Range(0, 2)) = 0
_BGColor ("BGColor", Color) = (0.2627451,0.5843138,0.9960785,0)
_Brightness ("Brightness", Float) = 3
_MainTex ("MainTex", 2D) = "white" { }
_StarTex ("StarTex", 2D) = "white" { }
_StarBrightness ("StarBrightness", Float) = 10
_StarDepth ("StarDepth", Float) = 14.89
_Star02Tex ("Star02Tex", 2D) = "white" { }
_Star02Brightness ("Star02Brightness", Float) = 10
_Star02Depth ("Star02Depth", Float) = 14.89
_CloudTex ("CloudTex", 2D) = "white" { }
_CloudOffset ("CloudOffset", Float) = 0
_CloudMultiplyer ("CloudMultiplyer", Float) = 11
_CloudSpeed ("CloudSpeed", Float) = 0.05
_GalaxyLightColor ("GalaxyLightColor", Color) = (0,1,0.7103448,0)
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseBrightness ("NoiseBrightness", Float) = 0.2
_NoiseSpeed ("NoiseSpeed", Float) = 0
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_Noise02Offset ("Noise02Offset", Float) = -0.05
_Noise02Multipler ("Noise02Multipler", Float) = 1
_GalaxyDarkColor ("GalaxyDarkColor", Color) = (0.7379308,0,1,0)
_DarkColorMultiplyer ("DarkColorMultiplyer", Float) = 1
_Mask02 ("Mask02", 2D) = "white" { }
_ColorPalette ("ColorPalette", 2D) = "white" { }
_ColorPaletteSpeed ("ColorPaletteSpeed", Float) = -1.95
_CloudDepth ("CloudDepth", Float) = 2
_CloudScale ("CloudScale", Float) = 0.1
_Range ("Range", Float) = 2.34
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
  GpuProgramID 50220
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.y;
    u_xlat1.z = u_xlat2.x;
    u_xlat0.xyw = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat0.xyw;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat10.x = _StarDepth + -1.0;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat0.xy = u_xlat10.xy * vec2(-0.100000001, -0.100000001) + u_xlat0.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2 = _CloudDepth + -1.0;
    u_xlat11.xy = u_xlat1.xy * vec2(u_xlat16_2);
    u_xlat5.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat5.xy;
    u_xlat5.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat5.xy;
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat10.xy;
    u_xlat10.xy = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat10.xy;
    u_xlat10_10 = texture(_MainTex, u_xlat10.xy).x;
    u_xlat0.x = u_xlat10_10 * u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat5.xz = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat3.xy;
    u_xlat10_5 = texture(_Mask02, u_xlat5.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat10_15 = texture(_NoiseTex02, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 + _Noise02Offset;
    u_xlat15 = u_xlat15 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + -1.0;
    u_xlat5.x = u_xlat10_5 * u_xlat15 + 1.0;
    u_xlat10.x = u_xlat5.x * u_xlat10_10;
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlat5.x = u_xlat5.x * _DarkColorMultiplyer;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat11.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat11.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat11.xy;
    u_xlat10_15 = texture(_CloudTex, u_xlat11.xy).x;
    u_xlat15 = u_xlat10_15 + _CloudOffset;
    u_xlat3.xyz = vec3(u_xlat15) * _GalaxyLightColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat10.xxx + u_xlat0.xxx;
    u_xlat4.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat4.xyz * u_xlat10.xxx + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat5.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat11.x = _Star02Depth + -1.0;
    u_xlat1.xy = u_xlat1.xy * u_xlat11.xx;
    u_xlat11.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(-0.100000001, -0.100000001) + u_xlat11.xy;
    u_xlat10_1 = texture(_Star02Tex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _Star02Brightness;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPaletteSpeed + u_xlat3.y;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat1.xyz = u_xlat10_6.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat10.xxx + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_2 = _Range * -0.5;
    u_xlat1.x = vs_TEXCOORD0.y * _Range + u_xlat16_2;
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.zxy * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.y;
    u_xlat5.z = u_xlat1.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat10.x = _StarDepth + -1.0;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat0.xy = u_xlat10.xy * vec2(-0.100000001, -0.100000001) + u_xlat0.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2 = _CloudDepth + -1.0;
    u_xlat11.xy = u_xlat1.xy * vec2(u_xlat16_2);
    u_xlat5.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat5.xy;
    u_xlat5.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat5.xy;
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat10.xy;
    u_xlat10.xy = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat10.xy;
    u_xlat10_10 = texture(_MainTex, u_xlat10.xy).x;
    u_xlat0.x = u_xlat10_10 * u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat5.xz = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat3.xy;
    u_xlat10_5 = texture(_Mask02, u_xlat5.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat10_15 = texture(_NoiseTex02, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 + _Noise02Offset;
    u_xlat15 = u_xlat15 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + -1.0;
    u_xlat5.x = u_xlat10_5 * u_xlat15 + 1.0;
    u_xlat10.x = u_xlat5.x * u_xlat10_10;
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlat5.x = u_xlat5.x * _DarkColorMultiplyer;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat11.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat11.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat11.xy;
    u_xlat10_15 = texture(_CloudTex, u_xlat11.xy).x;
    u_xlat15 = u_xlat10_15 + _CloudOffset;
    u_xlat3.xyz = vec3(u_xlat15) * _GalaxyLightColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat10.xxx + u_xlat0.xxx;
    u_xlat4.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat4.xyz * u_xlat10.xxx + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat5.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat11.x = _Star02Depth + -1.0;
    u_xlat1.xy = u_xlat1.xy * u_xlat11.xx;
    u_xlat11.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(-0.100000001, -0.100000001) + u_xlat11.xy;
    u_xlat10_1 = texture(_Star02Tex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _Star02Brightness;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPaletteSpeed + u_xlat3.y;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat1.xyz = u_xlat10_6.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat10.xxx + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_2 = _Range * -0.5;
    u_xlat1.x = vs_TEXCOORD0.y * _Range + u_xlat16_2;
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.y;
    u_xlat1.z = u_xlat2.x;
    u_xlat0.xyw = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat0.xyw;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_6;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat20;
lowp float u_xlat10_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat12.xx * vs_TEXCOORD4.xy;
    u_xlat16_1 = _CloudDepth + -1.0;
    u_xlat2.xy = u_xlat12.xy * vec2(u_xlat16_1);
    u_xlat0.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat0.xy;
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat14.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat14.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat3.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat3.xy;
    u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat14.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat14.xy;
    u_xlat10_14 = texture(_MainTex, u_xlat14.xy).x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat9.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat9.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat4.xy;
    u_xlat10_20 = texture(_NoiseTex02, u_xlat9.xy).x;
    u_xlat20 = u_xlat10_20 + _Noise02Offset;
    u_xlat20 = u_xlat20 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask02, u_xlat2.xy).x;
    u_xlat8 = u_xlat20 + -1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat8 + 1.0;
    u_xlat8 = u_xlat2.x * u_xlat10_14;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat20 = _StarDepth + -1.0;
    u_xlat15.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat3.xy = u_xlat15.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat15.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat20 = _Star02Depth + -1.0;
    u_xlat12.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat12.xy = u_xlat12.xy * vec2(-0.100000001, -0.100000001) + u_xlat15.xy;
    u_xlat4.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat4.x = _Time.y * _ColorPaletteSpeed + u_xlat4.y;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + _CloudOffset;
    u_xlat5.xyz = u_xlat0.xxx * _GalaxyLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat10_0 = texture(_StarTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat0.x = u_xlat10_14 * u_xlat0.x;
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat0.xxx;
    u_xlat5.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = u_xlat0.x * _DarkColorMultiplyer;
    u_xlat2.xzw = u_xlat0.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat10_0 = texture(_Star02Tex, u_xlat12.xy).x;
    u_xlat0.x = u_xlat10_0 * _Star02Brightness;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat4.xz).xyz;
    u_xlat0.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8) + u_xlat2.xzw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_1 = _Range * -0.5;
    u_xlat2.x = vs_TEXCOORD0.y * _Range + u_xlat16_1;
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.zxy * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.y;
    u_xlat5.z = u_xlat1.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_6;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat20;
lowp float u_xlat10_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat12.xx * vs_TEXCOORD4.xy;
    u_xlat16_1 = _CloudDepth + -1.0;
    u_xlat2.xy = u_xlat12.xy * vec2(u_xlat16_1);
    u_xlat0.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat0.xy;
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat14.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat14.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat3.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat3.xy;
    u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat14.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat14.xy;
    u_xlat10_14 = texture(_MainTex, u_xlat14.xy).x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat9.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat9.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat4.xy;
    u_xlat10_20 = texture(_NoiseTex02, u_xlat9.xy).x;
    u_xlat20 = u_xlat10_20 + _Noise02Offset;
    u_xlat20 = u_xlat20 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask02, u_xlat2.xy).x;
    u_xlat8 = u_xlat20 + -1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat8 + 1.0;
    u_xlat8 = u_xlat2.x * u_xlat10_14;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat20 = _StarDepth + -1.0;
    u_xlat15.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat3.xy = u_xlat15.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat15.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat20 = _Star02Depth + -1.0;
    u_xlat12.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat12.xy = u_xlat12.xy * vec2(-0.100000001, -0.100000001) + u_xlat15.xy;
    u_xlat4.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat4.x = _Time.y * _ColorPaletteSpeed + u_xlat4.y;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + _CloudOffset;
    u_xlat5.xyz = u_xlat0.xxx * _GalaxyLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat10_0 = texture(_StarTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat0.x = u_xlat10_14 * u_xlat0.x;
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat0.xxx;
    u_xlat5.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = u_xlat0.x * _DarkColorMultiplyer;
    u_xlat2.xzw = u_xlat0.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat10_0 = texture(_Star02Tex, u_xlat12.xy).x;
    u_xlat0.x = u_xlat10_0 * _Star02Brightness;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat4.xz).xyz;
    u_xlat0.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8) + u_xlat2.xzw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_1 = _Range * -0.5;
    u_xlat2.x = vs_TEXCOORD0.y * _Range + u_xlat16_1;
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.y;
    u_xlat1.z = u_xlat2.x;
    u_xlat0.xyw = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat0.xyw;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat10.x = _StarDepth + -1.0;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat0.xy = u_xlat10.xy * vec2(-0.100000001, -0.100000001) + u_xlat0.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2 = _CloudDepth + -1.0;
    u_xlat11.xy = u_xlat1.xy * vec2(u_xlat16_2);
    u_xlat5.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat5.xy;
    u_xlat5.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat5.xy;
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat10.xy;
    u_xlat10.xy = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat10.xy;
    u_xlat10_10 = texture(_MainTex, u_xlat10.xy).x;
    u_xlat0.x = u_xlat10_10 * u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat5.xz = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat3.xy;
    u_xlat10_5 = texture(_Mask02, u_xlat5.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat10_15 = texture(_NoiseTex02, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 + _Noise02Offset;
    u_xlat15 = u_xlat15 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + -1.0;
    u_xlat5.x = u_xlat10_5 * u_xlat15 + 1.0;
    u_xlat10.x = u_xlat5.x * u_xlat10_10;
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlat5.x = u_xlat5.x * _DarkColorMultiplyer;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat11.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat11.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat11.xy;
    u_xlat10_15 = texture(_CloudTex, u_xlat11.xy).x;
    u_xlat15 = u_xlat10_15 + _CloudOffset;
    u_xlat3.xyz = vec3(u_xlat15) * _GalaxyLightColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat10.xxx + u_xlat0.xxx;
    u_xlat4.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat4.xyz * u_xlat10.xxx + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat5.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat11.x = _Star02Depth + -1.0;
    u_xlat1.xy = u_xlat1.xy * u_xlat11.xx;
    u_xlat11.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(-0.100000001, -0.100000001) + u_xlat11.xy;
    u_xlat10_1 = texture(_Star02Tex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _Star02Brightness;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPaletteSpeed + u_xlat3.y;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat1.xyz = u_xlat10_6.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat10.xxx + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_2 = _Range * -0.5;
    u_xlat1.x = vs_TEXCOORD0.y * _Range + u_xlat16_2;
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.zxy * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.y;
    u_xlat5.z = u_xlat1.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp float u_xlat10_1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
lowp vec3 u_xlat10_6;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat10.x = _StarDepth + -1.0;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat0.xy = u_xlat10.xy * vec2(-0.100000001, -0.100000001) + u_xlat0.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat16_2 = _CloudDepth + -1.0;
    u_xlat11.xy = u_xlat1.xy * vec2(u_xlat16_2);
    u_xlat5.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat5.xy;
    u_xlat5.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat5.xy;
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat10.xy;
    u_xlat10.xy = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat10.xy;
    u_xlat10_10 = texture(_MainTex, u_xlat10.xy).x;
    u_xlat0.x = u_xlat10_10 * u_xlat0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat5.xz = vec2(u_xlat10_5) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat3.xy;
    u_xlat10_5 = texture(_Mask02, u_xlat5.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat3.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat10_15 = texture(_NoiseTex02, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 + _Noise02Offset;
    u_xlat15 = u_xlat15 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + -1.0;
    u_xlat5.x = u_xlat10_5 * u_xlat15 + 1.0;
    u_xlat10.x = u_xlat5.x * u_xlat10_10;
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlat5.x = u_xlat5.x * _DarkColorMultiplyer;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat11.xy = u_xlat11.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat11.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat11.xy;
    u_xlat10_15 = texture(_CloudTex, u_xlat11.xy).x;
    u_xlat15 = u_xlat10_15 + _CloudOffset;
    u_xlat3.xyz = vec3(u_xlat15) * _GalaxyLightColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat10.xxx + u_xlat0.xxx;
    u_xlat4.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat4.xyz * u_xlat10.xxx + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat5.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat11.x = _Star02Depth + -1.0;
    u_xlat1.xy = u_xlat1.xy * u_xlat11.xx;
    u_xlat11.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(-0.100000001, -0.100000001) + u_xlat11.xy;
    u_xlat10_1 = texture(_Star02Tex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _Star02Brightness;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPaletteSpeed + u_xlat3.y;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat1.xyz = u_xlat10_6.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat10.xxx + u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_2 = _Range * -0.5;
    u_xlat1.x = vs_TEXCOORD0.y * _Range + u_xlat16_2;
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.y;
    u_xlat1.z = u_xlat2.x;
    u_xlat0.xyw = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat0.xyw;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_6;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat20;
lowp float u_xlat10_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat12.xx * vs_TEXCOORD4.xy;
    u_xlat16_1 = _CloudDepth + -1.0;
    u_xlat2.xy = u_xlat12.xy * vec2(u_xlat16_1);
    u_xlat0.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat0.xy;
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat14.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat14.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat3.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat3.xy;
    u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat14.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat14.xy;
    u_xlat10_14 = texture(_MainTex, u_xlat14.xy).x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat9.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat9.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat4.xy;
    u_xlat10_20 = texture(_NoiseTex02, u_xlat9.xy).x;
    u_xlat20 = u_xlat10_20 + _Noise02Offset;
    u_xlat20 = u_xlat20 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask02, u_xlat2.xy).x;
    u_xlat8 = u_xlat20 + -1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat8 + 1.0;
    u_xlat8 = u_xlat2.x * u_xlat10_14;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat20 = _StarDepth + -1.0;
    u_xlat15.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat3.xy = u_xlat15.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat15.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat20 = _Star02Depth + -1.0;
    u_xlat12.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat12.xy = u_xlat12.xy * vec2(-0.100000001, -0.100000001) + u_xlat15.xy;
    u_xlat4.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat4.x = _Time.y * _ColorPaletteSpeed + u_xlat4.y;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + _CloudOffset;
    u_xlat5.xyz = u_xlat0.xxx * _GalaxyLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat10_0 = texture(_StarTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat0.x = u_xlat10_14 * u_xlat0.x;
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat0.xxx;
    u_xlat5.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = u_xlat0.x * _DarkColorMultiplyer;
    u_xlat2.xzw = u_xlat0.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat10_0 = texture(_Star02Tex, u_xlat12.xy).x;
    u_xlat0.x = u_xlat10_0 * _Star02Brightness;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat4.xz).xyz;
    u_xlat0.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8) + u_xlat2.xzw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_1 = _Range * -0.5;
    u_xlat2.x = vs_TEXCOORD0.y * _Range + u_xlat16_1;
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
out highp vec4 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.zxy * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.y;
    u_xlat5.z = u_xlat1.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _GalaxyLightColor;
uniform 	vec4 _CloudTex_ST;
uniform 	mediump float _CloudDepth;
uniform 	mediump float _CloudScale;
uniform 	float _CloudSpeed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseBrightness;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Offset;
uniform 	float _Noise02Multipler;
uniform 	vec4 _Mask02_ST;
uniform 	float _StarBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	float _StarDepth;
uniform 	vec4 _BGColor;
uniform 	float _Brightness;
uniform 	float _DarkColorMultiplyer;
uniform 	vec4 _GalaxyDarkColor;
uniform 	float _Star02Brightness;
uniform 	vec4 _Star02Tex_ST;
uniform 	float _Star02Depth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPaletteSpeed;
uniform 	float _FadeValue;
uniform 	mediump float _Range;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _Mask02;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _Star02Tex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_6;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat20;
lowp float u_xlat10_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.xy = u_xlat12.xx * vs_TEXCOORD4.xy;
    u_xlat16_1 = _CloudDepth + -1.0;
    u_xlat2.xy = u_xlat12.xy * vec2(u_xlat16_1);
    u_xlat0.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat0.xy;
    u_xlat14.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat14.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat14.xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat3.xy;
    u_xlat3.xy = _Time.yy * vec2(_NoiseSpeed) + u_xlat3.xy;
    u_xlat10_3 = texture(_NoiseTex, u_xlat3.xy).x;
    u_xlat14.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat14.xy;
    u_xlat10_14 = texture(_MainTex, u_xlat14.xy).x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat9.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat9.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Mask02_ST.xy + _Mask02_ST.zw;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_CloudScale, _CloudScale)) + u_xlat4.xy;
    u_xlat10_20 = texture(_NoiseTex02, u_xlat9.xy).x;
    u_xlat20 = u_xlat10_20 + _Noise02Offset;
    u_xlat20 = u_xlat20 * _Noise02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat2.xy = vec2(u_xlat10_3) * vec2(vec2(_NoiseBrightness, _NoiseBrightness)) + u_xlat2.xy;
    u_xlat10_2 = texture(_Mask02, u_xlat2.xy).x;
    u_xlat8 = u_xlat20 + -1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat8 + 1.0;
    u_xlat8 = u_xlat2.x * u_xlat10_14;
    u_xlat3.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat20 = _StarDepth + -1.0;
    u_xlat15.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat3.xy = u_xlat15.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat15.xy = vs_TEXCOORD0.xy * _Star02Tex_ST.xy + _Star02Tex_ST.zw;
    u_xlat20 = _Star02Depth + -1.0;
    u_xlat12.xy = u_xlat12.xy * vec2(u_xlat20);
    u_xlat12.xy = u_xlat12.xy * vec2(-0.100000001, -0.100000001) + u_xlat15.xy;
    u_xlat4.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat4.x = _Time.y * _ColorPaletteSpeed + u_xlat4.y;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + _CloudOffset;
    u_xlat5.xyz = u_xlat0.xxx * _GalaxyLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_CloudMultiplyer, _CloudMultiplyer, _CloudMultiplyer));
    u_xlat10_0 = texture(_StarTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_0 * _StarBrightness;
    u_xlat0.x = u_xlat10_14 * u_xlat0.x;
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat0.xxx;
    u_xlat5.xyz = _BGColor.xyz * vec3(_Brightness);
    u_xlat3.xyz = u_xlat5.xyz * vec3(u_xlat8) + u_xlat3.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = u_xlat0.x * _DarkColorMultiplyer;
    u_xlat2.xzw = u_xlat0.xxx * _GalaxyDarkColor.xyz + u_xlat3.xyz;
    u_xlat10_0 = texture(_Star02Tex, u_xlat12.xy).x;
    u_xlat0.x = u_xlat10_0 * _Star02Brightness;
    u_xlat10_6.xyz = texture(_ColorPalette, u_xlat4.xz).xyz;
    u_xlat0.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8) + u_xlat2.xzw;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_FadeValue, _FadeValue, _FadeValue));
    u_xlat16_1 = _Range * -0.5;
    u_xlat2.x = vs_TEXCOORD0.y * _Range + u_xlat16_1;
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat0.w = u_xlat0.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
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
}
CustomEditor "MiHoYoASEMaterialInspector"
}