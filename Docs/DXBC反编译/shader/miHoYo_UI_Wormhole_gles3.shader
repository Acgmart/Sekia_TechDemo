//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/Wormhole" {
Properties {
_Cloud01_Color ("Cloud01_Color", Color) = (0,1,0.7103448,0)
_CloudTex ("CloudTex", 2D) = "white" { }
_CloudOffset ("CloudOffset", Float) = 0
_CloudMultiplyer ("CloudMultiplyer", Float) = 2.5
_Cloud_U_Speed ("Cloud_U_Speed", Float) = 0.05
_Cloud_V_Speed ("Cloud_V_Speed", Float) = 0.05
_Cloud02_Color ("Cloud02_Color", Color) = (1,0.3676471,0.3676471,0)
_Cloud02Tex ("Cloud02Tex", 2D) = "white" { }
_Cloud02Offset ("Cloud02Offset", Float) = -0.09
_Cloud02Multipler ("Cloud02Multipler", Float) = 2.5
_Cloud02_U_Speed ("Cloud02_U_Speed", Float) = 0.05
_Cloud02_V_Speed ("Cloud02_V_Speed", Float) = 0.005
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseOffset ("NoiseOffset", Float) = 0.08
_NoiseBrightness ("NoiseBrightness", Float) = 3.01
_NoiseSpeed ("NoiseSpeed", Float) = 0.01
_StarTex ("StarTex", 2D) = "black" { }
_StarBrightness ("StarBrightness", Float) = 10
_Star_U_Speed ("Star_U_Speed", Float) = 0.05
_Star_V_Speed ("Star_V_Speed", Float) = 0.005
_StarDepth ("StarDepth", Float) = 14.89
_ColorPalette ("ColorPalette", 2D) = "white" { }
_ColorPalletteSpeed ("ColorPalletteSpeed", Float) = -1.95
_Opacity ("Opacity", Range(0, 1)) = 1
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
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 225
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1 = texture(_CameraNormalsTexture, u_xlat1.xy).w;
    u_xlat16_3 = u_xlat10_1 * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
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
uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1 = texture(_CameraNormalsTexture, u_xlat1.xy).w;
    u_xlat16_3 = u_xlat10_1 * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1 = texture(_CameraNormalsTexture, u_xlat1.xy).w;
    u_xlat16_3 = u_xlat10_1 * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1 = texture(_CameraNormalsTexture, u_xlat1.xy).w;
    u_xlat16_3 = u_xlat10_1 * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
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
uniform 	vec4 _ProjectionParams;
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat11;
lowp float u_xlat10_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat10.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat10.y;
    u_xlat10_10 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_10 + _CloudOffset;
    u_xlat15 = u_xlat15 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat6.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_11 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat11 = u_xlat10_11 + _NoiseOffset;
    u_xlat11 = u_xlat11 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat15) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat6.xxx + (-u_xlat2.xyz);
    u_xlat6.xyz = vec3(u_xlat11) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat15 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat15);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat0.xy).w;
    u_xlat16_4 = u_xlat10_0 * 255.0 + 0.499000013;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat0.x = u_xlat16_4 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_10 = u_xlat10_10 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_10) + u_xlat6.xyz;
    SV_Target0 = u_xlat4;
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat11;
lowp float u_xlat10_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat10.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat10.y;
    u_xlat10_10 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_10 + _CloudOffset;
    u_xlat15 = u_xlat15 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat6.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_11 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat11 = u_xlat10_11 + _NoiseOffset;
    u_xlat11 = u_xlat11 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat15) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat6.xxx + (-u_xlat2.xyz);
    u_xlat6.xyz = vec3(u_xlat11) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat15 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat15);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat0.xy).w;
    u_xlat16_4 = u_xlat10_0 * 255.0 + 0.499000013;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat0.x = u_xlat16_4 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_10 = u_xlat10_10 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_10) + u_xlat6.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat11;
lowp float u_xlat10_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat10.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat10.y;
    u_xlat10_10 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_10 + _CloudOffset;
    u_xlat15 = u_xlat15 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat6.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_11 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat11 = u_xlat10_11 + _NoiseOffset;
    u_xlat11 = u_xlat11 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat15) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat6.xxx + (-u_xlat2.xyz);
    u_xlat6.xyz = vec3(u_xlat11) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat15 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat15);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat0.xy).w;
    u_xlat16_4 = u_xlat10_0 * 255.0 + 0.499000013;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat0.x = u_xlat16_4 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_10 = u_xlat10_10 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_10) + u_xlat6.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat6;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
float u_xlat11;
lowp float u_xlat10_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat10.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat10.y;
    u_xlat10_10 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_10 + _CloudOffset;
    u_xlat15 = u_xlat15 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat6.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_11 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat11 = u_xlat10_11 + _NoiseOffset;
    u_xlat11 = u_xlat11 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat15) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat6.xxx + (-u_xlat2.xyz);
    u_xlat6.xyz = vec3(u_xlat11) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * vs_TEXCOORD4.xy;
    u_xlat15 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat15);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat0.xy).w;
    u_xlat16_4 = u_xlat10_0 * 255.0 + 0.499000013;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat0.x = u_xlat16_4 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_10 = u_xlat10_10 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_10) + u_xlat6.xyz;
    SV_Target0 = u_xlat4;
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ScreenParams;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
uvec4 u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat1.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat1.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).w;
    u_xlat16_3 = u_xlat1.x * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
    SV_Target0 = u_xlat0;
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
uvec4 u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat1.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat1.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).w;
    u_xlat16_3 = u_xlat1.x * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ScreenParams;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
uvec4 u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat1.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat1.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).w;
    u_xlat16_3 = u_xlat1.x * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
uvec4 u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
vec2 u_xlat9;
lowp float u_xlat10_9;
float u_xlat12;
lowp float u_xlat10_12;
float u_xlat13;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vs_TEXCOORD4.xy;
    u_xlat8.x = _StarDepth + -1.0;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xx;
    u_xlat8.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat1.x = _Time.y * _Star_U_Speed + u_xlat8.x;
    u_xlat1.y = _Time.y * _Star_V_Speed + u_xlat8.y;
    u_xlat0.xy = u_xlat0.xy * vec2(-0.100000001, -0.100000001) + u_xlat1.xy;
    u_xlat10_0 = texture(_StarTex, u_xlat0.xy).x;
    u_xlat1.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat1.x = _Time.y * _ColorPalletteSpeed + u_xlat1.y;
    u_xlat10_4.xyz = texture(_ColorPalette, u_xlat1.xz).xyz;
    u_xlat16_0.xyz = u_xlat10_4.xyz * vec3(u_xlat10_0);
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = _Time.y * _NoiseSpeed + u_xlat1.y;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xz).x;
    u_xlat12 = u_xlat10_12 + _NoiseOffset;
    u_xlat12 = u_xlat12 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat5.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat5.x = u_xlat5.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud_U_Speed + u_xlat9.x;
    u_xlat2.y = _Time.y * _Cloud_V_Speed + u_xlat9.y;
    u_xlat10_9 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat13 = u_xlat10_9 + _CloudOffset;
    u_xlat16_1 = u_xlat10_1 * u_xlat10_9;
    u_xlat9.x = u_xlat13 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat9.xxx * _Cloud01_Color.xyz;
    u_xlat5.xyz = _Cloud02_Color.xyz * u_xlat5.xxx + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_1) + u_xlat5.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat1.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat1.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).w;
    u_xlat16_3 = u_xlat1.x * 255.0 + 0.499000013;
    u_xlat16_3 = floor(u_xlat16_3);
    u_xlat1.x = u_xlat16_3 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(abs(u_xlat1.x)>=0.100000001);
#else
    u_xlatb1 = abs(u_xlat1.x)>=0.100000001;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.w = u_xlat1.x * _Opacity;
    SV_Target0 = u_xlat0;
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
uvec4 u_xlatu4;
mediump float u_xlat16_5;
vec3 u_xlat7;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat13;
lowp float u_xlat10_13;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat12.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat12.y;
    u_xlat10_12 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_12 + _CloudOffset;
    u_xlat18 = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat7.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat7.x = u_xlat7.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_13 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat13 = u_xlat10_13 + _NoiseOffset;
    u_xlat13 = u_xlat13 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat7.xxx + (-u_xlat2.xyz);
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * vs_TEXCOORD4.xy;
    u_xlat18 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat18);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlatu4.xy = uvec2(ivec2(u_xlat0.xy));
    u_xlatu4.z = uint(uint(0u));
    u_xlatu4.w = uint(uint(0u));
    u_xlat0.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu4.xy), 0).w;
    u_xlat16_5 = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat0.x = u_xlat16_5 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_12 = u_xlat10_12 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_12) + u_xlat7.xyz;
    SV_Target0 = u_xlat4;
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
uvec4 u_xlatu4;
mediump float u_xlat16_5;
vec3 u_xlat7;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat13;
lowp float u_xlat10_13;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat12.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat12.y;
    u_xlat10_12 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_12 + _CloudOffset;
    u_xlat18 = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat7.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat7.x = u_xlat7.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_13 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat13 = u_xlat10_13 + _NoiseOffset;
    u_xlat13 = u_xlat13 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat7.xxx + (-u_xlat2.xyz);
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * vs_TEXCOORD4.xy;
    u_xlat18 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat18);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlatu4.xy = uvec2(ivec2(u_xlat0.xy));
    u_xlatu4.z = uint(uint(0u));
    u_xlatu4.w = uint(uint(0u));
    u_xlat0.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu4.xy), 0).w;
    u_xlat16_5 = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat0.x = u_xlat16_5 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_12 = u_xlat10_12 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_12) + u_xlat7.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
uvec4 u_xlatu4;
mediump float u_xlat16_5;
vec3 u_xlat7;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat13;
lowp float u_xlat10_13;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat12.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat12.y;
    u_xlat10_12 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_12 + _CloudOffset;
    u_xlat18 = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat7.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat7.x = u_xlat7.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_13 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat13 = u_xlat10_13 + _NoiseOffset;
    u_xlat13 = u_xlat13 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat7.xxx + (-u_xlat2.xyz);
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * vs_TEXCOORD4.xy;
    u_xlat18 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat18);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlatu4.xy = uvec2(ivec2(u_xlat0.xy));
    u_xlatu4.z = uint(uint(0u));
    u_xlatu4.w = uint(uint(0u));
    u_xlat0.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu4.xy), 0).w;
    u_xlat16_5 = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat0.x = u_xlat16_5 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_12 = u_xlat10_12 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_12) + u_xlat7.xyz;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.zxy * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.z;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _Opacity;
uniform 	vec4 _Cloud01_Color;
uniform 	float _Cloud_U_Speed;
uniform 	vec4 _CloudTex_ST;
uniform 	float _Cloud_V_Speed;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02_Color;
uniform 	float _Cloud02_U_Speed;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02_V_Speed;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	float _Star_U_Speed;
uniform 	vec4 _StarTex_ST;
uniform 	float _Star_V_Speed;
uniform 	float _StarDepth;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	float _StarBrightness;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat4;
uvec4 u_xlatu4;
mediump float u_xlat16_5;
vec3 u_xlat7;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat13;
lowp float u_xlat10_13;
float u_xlat18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat12.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat1.x = _Time.y * _Cloud_U_Speed + u_xlat12.x;
    u_xlat1.y = _Time.y * _Cloud_V_Speed + u_xlat12.y;
    u_xlat10_12 = texture(_CloudTex, u_xlat1.xy).x;
    u_xlat18 = u_xlat10_12 + _CloudOffset;
    u_xlat18 = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat2.x = _Time.y * _Cloud02_U_Speed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Cloud02_V_Speed + u_xlat1.y;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat2.xy).x;
    u_xlat7.x = u_xlat10_1 + _Cloud02Offset;
    u_xlat7.x = u_xlat7.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat10_13 = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat13 = u_xlat10_13 + _NoiseOffset;
    u_xlat13 = u_xlat13 * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * _Cloud01_Color.xyz;
    u_xlat3.xyz = _Cloud02_Color.xyz * u_xlat7.xxx + (-u_xlat2.xyz);
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _Star_U_Speed + u_xlat2.x;
    u_xlat3.y = _Time.y * _Star_V_Speed + u_xlat2.y;
    u_xlat18 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * vs_TEXCOORD4.xy;
    u_xlat18 = _StarDepth + -1.0;
    u_xlat2.xy = u_xlat2.xy * vec2(u_xlat18);
    u_xlat2.xy = u_xlat2.xy * vec2(-0.100000001, -0.100000001) + u_xlat3.xy;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlatu4.xy = uvec2(ivec2(u_xlat0.xy));
    u_xlatu4.z = uint(uint(0u));
    u_xlatu4.w = uint(uint(0u));
    u_xlat0.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu4.xy), 0).w;
    u_xlat16_5 = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat0.x = u_xlat16_5 + -4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(abs(u_xlat0.x)>=0.100000001);
#else
    u_xlatb0.x = abs(u_xlat0.x)>=0.100000001;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4.w = u_xlat0.x * _Opacity;
    u_xlat10_0 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat10_2.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_0.xyw = vec3(u_xlat10_0) * u_xlat10_2.xyz;
    u_xlat0.xyw = u_xlat16_0.xyw * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat16_12 = u_xlat10_12 * u_xlat10_1;
    u_xlat4.xyz = u_xlat0.xyw * vec3(u_xlat16_12) + u_xlat7.xyz;
    SV_Target0 = u_xlat4;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}