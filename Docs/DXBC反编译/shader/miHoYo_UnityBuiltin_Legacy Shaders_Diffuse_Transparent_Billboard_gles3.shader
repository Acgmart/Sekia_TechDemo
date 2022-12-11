//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UnityBuiltin/Legacy Shaders/Diffuse_Transparent_Billboard" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_EmissionScale ("EmissionScale", Range(0, 3)) = 0.5
_ShadowStrength ("ShadowStrength", Range(0, 1)) = 0.5
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 54612
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_2 = texture(_ShadowMapTexture, u_xlat2.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat4.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmissionScale);
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.x = u_xlat21 * in_POSITION0.x;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.y = u_xlat21 * in_POSITION0.y;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.z = u_xlat21 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_5 = u_xlat1.y * u_xlat1.y;
    u_xlat16_5 = u_xlat1.x * u_xlat1.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat6.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat6.x + _ShadowStrength;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat6.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_2.x = log2(u_xlat16_1.w);
    u_xlat16_2.x = u_xlat16_2.x * unity_Lightmap_HDR.y;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * unity_Lightmap_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat6.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat6.x + _ShadowStrength;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat6.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat8;
mediump float u_xlat16_15;
float u_xlat18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_15 = log2(u_xlat16_1.w);
    u_xlat16_15 = u_xlat16_15 * unity_Lightmap_HDR.y;
    u_xlat16_15 = exp2(u_xlat16_15);
    u_xlat16_15 = u_xlat16_15 * unity_Lightmap_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat8.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat8.x + _ShadowStrength;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat8.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat3.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_2 = texture(_ShadowMapTexture, u_xlat2.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat4.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmissionScale);
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.x = u_xlat21 * in_POSITION0.x;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.y = u_xlat21 * in_POSITION0.y;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.z = u_xlat21 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat4 = u_xlat2.yyyy * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat4;
    u_xlat3 = u_xlat1 * u_xlat2.zzzz + u_xlat3;
    u_xlat0 = u_xlat1 * u_xlat1 + u_xlat0;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat6.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat6.x + _ShadowStrength;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat6.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati15 = u_xlati15 << 3;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.x = u_xlat16 * in_POSITION0.x;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.y = u_xlat16 * in_POSITION0.y;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.z = u_xlat16 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat0.y = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat0.z = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_2 = texture(_ShadowMapTexture, u_xlat2.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat4.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmissionScale);
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
int u_xlati21;
float u_xlat22;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.x = u_xlat22 * in_POSITION0.x;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.y = u_xlat22 * in_POSITION0.y;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.z = u_xlat22 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat0.y = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat0.z = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat21 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat6.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat6.x + _ShadowStrength;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat6.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
ivec4 u_xlati3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3.xw = ivec2(u_xlati15) << ivec2(3, 1);
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat1.y = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat1.z = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.zw;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_2.x = log2(u_xlat16_1.w);
    u_xlat16_2.x = u_xlat16_2.x * unity_Lightmap_HDR.y;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * unity_Lightmap_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat6.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat6.x + _ShadowStrength;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat6.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
ivec4 u_xlati3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3.xw = ivec2(u_xlati15) << ivec2(3, 1);
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat1.y = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat1.z = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.zw;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat8;
mediump float u_xlat16_15;
float u_xlat18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
    u_xlat16_15 = log2(u_xlat16_1.w);
    u_xlat16_15 = u_xlat16_15 * unity_Lightmap_HDR.y;
    u_xlat16_15 = exp2(u_xlat16_15);
    u_xlat16_15 = u_xlat16_15 * unity_Lightmap_HDR.x;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat8.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat8.x + _ShadowStrength;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat8.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat3.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati15 = u_xlati15 << 3;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.x = u_xlat16 * in_POSITION0.x;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.y = u_xlat16 * in_POSITION0.y;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.z = u_xlat16 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat0.y = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat0.z = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_2 = texture(_ShadowMapTexture, u_xlat2.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat4.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EmissionScale);
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
int u_xlati21;
float u_xlat22;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.x = u_xlat22 * in_POSITION0.x;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.y = u_xlat22 * in_POSITION0.y;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.z = u_xlat22 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat2.y = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat2.z = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat4 = u_xlat2.yyyy * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat4;
    u_xlat3 = u_xlat1 * u_xlat2.zzzz + u_xlat3;
    u_xlat0 = u_xlat1 * u_xlat1 + u_xlat0;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat6.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat6.x + _ShadowStrength;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat6.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat3.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_EmissionScale) + u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 77966
Program "vp" {
SubProgram "gles3 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform highp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.x = texture(_LightTexture0, u_xlat3.xx).w;
    u_xlat16_2.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat3.xy).x;
    u_xlat6.x = (-_ShadowStrength) + 1.0;
    u_xlat3.x = u_xlat10_3 * u_xlat6.x + _ShadowStrength;
    u_xlat6.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat6.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_2 = texture(_ShadowMapTexture, u_xlat2.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat2.x = u_xlat10_2 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat4.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat15 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat5.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat5.x + _ShadowStrength;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_1 = texture(_MainTexture, u_xlat5.xy);
    u_xlat1 = u_xlat10_1 * _MainColor;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat5.x = texture(_LightTextureB0, vec2(u_xlat15)).w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat5.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat5.x + _ShadowStrength;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2 = texture(_MainTexture, u_xlat5.xy);
    u_xlat2 = u_xlat10_2 * _MainColor;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform highp sampler2D _LightTexture0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2 = texture(_MainTexture, u_xlat4.xy);
    u_xlat2 = u_xlat10_2 * _MainColor;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "DEFERRED" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 145208
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat2.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat2.x + _ShadowStrength;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_EmissionScale);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.x = u_xlat21 * in_POSITION0.x;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.y = u_xlat21 * in_POSITION0.y;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.z = u_xlat21 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.y;
    u_xlat16_5 = u_xlat1.x * u_xlat1.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_3.x = log2(u_xlat16_2.w);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat5.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat5.x + _ShadowStrength;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_5.xyz = texture(_MainTexture, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_3.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_3.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_3.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_18 = log2(u_xlat16_2.w);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.y;
    u_xlat16_18 = exp2(u_xlat16_18);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.x = u_xlat21 * in_POSITION0.x;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.y = u_xlat21 * in_POSITION0.y;
    u_xlat21 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat4.z = u_xlat21 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.y;
    u_xlat16_5 = u_xlat1.x * u_xlat1.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    SV_Target3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_3.x = log2(u_xlat16_2.w);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    SV_Target3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].y;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat5.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat5.x + _ShadowStrength;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_5.xyz = texture(_MainTexture, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_3.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_3.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_3.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_18 = log2(u_xlat16_2.w);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.y;
    u_xlat16_18 = exp2(u_xlat16_18);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    SV_Target3.xyz = u_xlat5.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
int u_xlati15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati15 = u_xlati15 << 3;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.x = u_xlat16 * in_POSITION0.x;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.y = u_xlat16 * in_POSITION0.y;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.z = u_xlat16 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat0.y = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat0.z = unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat2.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat2.x + _ShadowStrength;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_2.xyz = texture(_MainTexture, u_xlat2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_EmissionScale);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
int u_xlati21;
float u_xlat22;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.x = u_xlat22 * in_POSITION0.x;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.y = u_xlat22 * in_POSITION0.y;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.z = u_xlat22 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat0.y = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat0.z = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat21 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
ivec4 u_xlati3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3.xw = ivec2(u_xlati15) << ivec2(3, 1);
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat4.x = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat4.z = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.zw;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_3.x = log2(u_xlat16_2.w);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
ivec4 u_xlati3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3.xw = ivec2(u_xlati15) << ivec2(3, 1);
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat4.x = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat4.z = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.zw;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat5.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat5.x + _ShadowStrength;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_5.xyz = texture(_MainTexture, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_3.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_3.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_3.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_18 = log2(u_xlat16_2.w);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.y;
    u_xlat16_18 = exp2(u_xlat16_18);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
int u_xlati21;
float u_xlat22;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.x = u_xlat22 * in_POSITION0.x;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.y = u_xlat22 * in_POSITION0.y;
    u_xlat22 = dot(unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat4.z = u_xlat22 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat1.www + u_xlat2.xyz;
    u_xlat1 = u_xlat2 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat0.y = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat0.z = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat21 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    SV_Target3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
ivec4 u_xlati3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3.xw = ivec2(u_xlati15) << ivec2(3, 1);
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat4.x = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat4.z = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.zw;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat4.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat4.x + _ShadowStrength;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_4.xyz = texture(_MainTexture, u_xlat4.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_3.x = log2(u_xlat16_2.w);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    SV_Target3.xyz = u_xlat4.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
ivec4 u_xlati3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlati15 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3.xw = ivec2(u_xlati15) << ivec2(3, 1);
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat4.x = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].y;
    u_xlat4.z = unity_Builtins0Array[u_xlati3.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].y;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati3.w / 2].unity_StaicLightMapSTArray.zw;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD6.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat5 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD6.w = u_xlat5 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat5.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat5.x + _ShadowStrength;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_5.xyz = texture(_MainTexture, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat2.w = 1.0;
    SV_Target2 = u_xlat2;
    u_xlat16_3.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_3.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_3.x);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
    u_xlat16_18 = log2(u_xlat16_2.w);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.y;
    u_xlat16_18 = exp2(u_xlat16_18);
    u_xlat16_18 = u_xlat16_18 * unity_Lightmap_HDR.x;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    SV_Target3.xyz = u_xlat5.xyz * vec3(_EmissionScale) + u_xlat16_3.xyz;
    SV_Target3.w = 1.0;
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
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "META" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 250094
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
bool u_xlatb16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.yxz;
    u_xlat1.x = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xzy;
    u_xlat1.y = u_xlat2.x;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat1.z = (-u_xlat3.x);
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.y = u_xlat15 * in_POSITION0.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat4.z = u_xlat15 * in_POSITION0.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.x = u_xlat0.z;
    u_xlat0.y = u_xlat2.z;
    u_xlat0.z = (-u_xlat3.y);
    u_xlat2.z = (-u_xlat3.z);
    u_xlat1.z = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat1.y = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[3] * in_POSITION0.wwww + u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb1 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat1.xyz = (unity_MetaVertexControl.x) ? u_xlat1.xyz : u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<u_xlat1.z);
#else
    u_xlatb16 = 0.0<u_xlat1.z;
#endif
    u_xlat2.z = u_xlatb16 ? 9.99999975e-05 : float(0.0);
    u_xlat2.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat1.xyz = (unity_MetaVertexControl.y) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _MainColor;
uniform 	vec4 _MainTexture_ST;
uniform 	float _EmissionScale;
uniform 	float _ShadowStrength;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat3.x = (-_ShadowStrength) + 1.0;
    u_xlat0.x = u_xlat10_0 * u_xlat3.x + _ShadowStrength;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat10_3.xyz = texture(_MainTexture, u_xlat3.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(_EmissionScale);
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat9 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
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
}
}
}
Fallback "Diffuse"
CustomEditor "MiHoYoASEMaterialInspector"
}