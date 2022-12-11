//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/GlassBall" {
Properties {
_CubeMap ("CubeMap", Cube) = "white" { }
_GlassColorExp ("GlassColorExp", Float) = 2
_GlassColor ("GlassColor", Color) = (0.1498703,0.9705882,0.2574127,1)
_TransmissionColor ("TransmissionColor", Color) = (0,0,0,1)
_TransmissionIntencity ("TransmissionIntencity", Float) = 1
_CenterTransparency ("CenterTransparency", Float) = 0.1
_TransparencyExp ("TransparencyExp", Float) = 3
_GlassTransparency ("GlassTransparency", Float) = 0.1
_CubeMapBrightness ("CubeMapBrightness", Float) = 1
_ReflectionIntensity ("ReflectionIntensity", Float) = 1
_MatcapTex ("MatcapTex", 2D) = "white" { }
_MatcapBrightness ("MatcapBrightness", Float) = 0
_GlassFlashing ("GlassFlashing", 2D) = "white" { }
_FlashColor ("FlashColor", Color) = (0,0,0,0)
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
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 27731
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat9)) + (-u_xlat1.xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _GlassFlashing_ST;
uniform 	vec4 _FlashColor;
uniform 	float _MatcapBrightness;
uniform 	float _GlassColorExp;
uniform 	vec4 _GlassColor;
uniform 	float _CubeMapBrightness;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _TransmissionColor;
uniform 	float _TransmissionIntencity;
uniform 	float _CenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _GlassTransparency;
uniform lowp sampler2D _GlassFlashing;
uniform lowp sampler2D _MatcapTex;
uniform lowp samplerCube _CubeMap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump float u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_11;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat16_21 = (-u_xlat7.x) + 1.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat7.x = log2(u_xlat18);
    u_xlat18 = max(u_xlat18, _CenterTransparency);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _TransparencyExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = u_xlat18 * _GlassTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat7.x * _GlassColorExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_7 = inversesqrt(u_xlat16_7);
    u_xlat7.xyz = vec3(u_xlat16_7) * vs_TEXCOORD1.xyz;
    u_xlat10_7.xyz = texture(_CubeMap, u_xlat7.xyz).xyz;
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_CubeMapBrightness);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat7.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_ReflectionIntensity, _ReflectionIntensity, _ReflectionIntensity));
    u_xlat7.xyz = vec3(u_xlat18) * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vs_TEXCOORD2.xx + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vs_TEXCOORD2.zz + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_4.xyz = texture(_MatcapTex, u_xlat4.xy).xyz;
    u_xlat7.xyz = u_xlat10_4.xyz * vec3(_MatcapBrightness) + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _GlassFlashing_ST.xy + _GlassFlashing_ST.zw;
    u_xlat4.xy = u_xlat4.xy + vec2(-0.109999999, 0.0);
    u_xlat10_18 = texture(_GlassFlashing, u_xlat4.xy).x;
    u_xlat7.xyz = vec3(u_xlat10_18) * _FlashColor.xyz + u_xlat7.xyz;
    u_xlat16_5 = max(u_xlat7.y, u_xlat7.x);
    u_xlat16_5 = max(u_xlat7.z, u_xlat16_5);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11.x = (-u_xlat16_5) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11.x = min(max(u_xlat16_11.x, 0.0), 1.0);
#else
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = (-u_xlat7.xyz) + u_xlat16_11.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_21) * u_xlat16_11.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat7.xyz * vec3(u_xlat16_5) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = max((-u_xlat16_3.x), 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat0.xyz = _TransmissionColor.xyz * vec3(_TransmissionIntencity);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat7.xyz * u_xlat16_3.xyz;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    SV_Target0.xyz = u_xlat7.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _GlassFlashing_ST;
uniform 	vec4 _FlashColor;
uniform 	float _MatcapBrightness;
uniform 	float _GlassColorExp;
uniform 	vec4 _GlassColor;
uniform 	float _CubeMapBrightness;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _TransmissionColor;
uniform 	float _TransmissionIntencity;
uniform 	float _CenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _GlassTransparency;
uniform lowp sampler2D _GlassFlashing;
uniform lowp sampler2D _MatcapTex;
uniform lowp samplerCube _CubeMap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump float u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_11;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat16_21 = (-u_xlat7.x) + 1.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat7.x = log2(u_xlat18);
    u_xlat18 = max(u_xlat18, _CenterTransparency);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _TransparencyExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = u_xlat18 * _GlassTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat7.x * _GlassColorExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_7 = inversesqrt(u_xlat16_7);
    u_xlat7.xyz = vec3(u_xlat16_7) * vs_TEXCOORD1.xyz;
    u_xlat10_7.xyz = texture(_CubeMap, u_xlat7.xyz).xyz;
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_CubeMapBrightness);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat7.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_ReflectionIntensity, _ReflectionIntensity, _ReflectionIntensity));
    u_xlat7.xyz = vec3(u_xlat18) * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vs_TEXCOORD2.xx + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vs_TEXCOORD2.zz + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_4.xyz = texture(_MatcapTex, u_xlat4.xy).xyz;
    u_xlat7.xyz = u_xlat10_4.xyz * vec3(_MatcapBrightness) + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _GlassFlashing_ST.xy + _GlassFlashing_ST.zw;
    u_xlat4.xy = u_xlat4.xy + vec2(-0.109999999, 0.0);
    u_xlat10_18 = texture(_GlassFlashing, u_xlat4.xy).x;
    u_xlat7.xyz = vec3(u_xlat10_18) * _FlashColor.xyz + u_xlat7.xyz;
    u_xlat16_5 = max(u_xlat7.y, u_xlat7.x);
    u_xlat16_5 = max(u_xlat7.z, u_xlat16_5);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11.x = (-u_xlat16_5) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11.x = min(max(u_xlat16_11.x, 0.0), 1.0);
#else
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = (-u_xlat7.xyz) + u_xlat16_11.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_21) * u_xlat16_11.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat7.xyz * vec3(u_xlat16_5) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = max((-u_xlat16_3.x), 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat0.xyz = _TransmissionColor.xyz * vec3(_TransmissionIntencity);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat7.xyz * u_xlat16_3.xyz;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    SV_Target0.xyz = u_xlat7.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
    u_xlat0.x = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat1.xyz * (-u_xlat0.xxx) + (-u_xlat2.xyz);
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _GlassFlashing_ST;
uniform 	vec4 _FlashColor;
uniform 	float _MatcapBrightness;
uniform 	float _GlassColorExp;
uniform 	vec4 _GlassColor;
uniform 	float _CubeMapBrightness;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _TransmissionColor;
uniform 	float _TransmissionIntencity;
uniform 	float _CenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _GlassTransparency;
uniform lowp sampler2D _GlassFlashing;
uniform lowp sampler2D _MatcapTex;
uniform lowp samplerCube _CubeMap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump float u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_11;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat16_21 = (-u_xlat7.x) + 1.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat7.x = log2(u_xlat18);
    u_xlat18 = max(u_xlat18, _CenterTransparency);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _TransparencyExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = u_xlat18 * _GlassTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat7.x * _GlassColorExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_7 = inversesqrt(u_xlat16_7);
    u_xlat7.xyz = vec3(u_xlat16_7) * vs_TEXCOORD1.xyz;
    u_xlat10_7.xyz = texture(_CubeMap, u_xlat7.xyz).xyz;
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_CubeMapBrightness);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat7.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_ReflectionIntensity, _ReflectionIntensity, _ReflectionIntensity));
    u_xlat7.xyz = vec3(u_xlat18) * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vs_TEXCOORD2.xx + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vs_TEXCOORD2.zz + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_4.xyz = texture(_MatcapTex, u_xlat4.xy).xyz;
    u_xlat7.xyz = u_xlat10_4.xyz * vec3(_MatcapBrightness) + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _GlassFlashing_ST.xy + _GlassFlashing_ST.zw;
    u_xlat4.xy = u_xlat4.xy + vec2(-0.109999999, 0.0);
    u_xlat10_18 = texture(_GlassFlashing, u_xlat4.xy).x;
    u_xlat7.xyz = vec3(u_xlat10_18) * _FlashColor.xyz + u_xlat7.xyz;
    u_xlat16_5 = max(u_xlat7.y, u_xlat7.x);
    u_xlat16_5 = max(u_xlat7.z, u_xlat16_5);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11.x = (-u_xlat16_5) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11.x = min(max(u_xlat16_11.x, 0.0), 1.0);
#else
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = (-u_xlat7.xyz) + u_xlat16_11.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_21) * u_xlat16_11.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat7.xyz * vec3(u_xlat16_5) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = max((-u_xlat16_3.x), 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat0.xyz = _TransmissionColor.xyz * vec3(_TransmissionIntencity);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat7.xyz * u_xlat16_3.xyz;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    SV_Target0.xyz = u_xlat7.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3.xyz = u_xlat5.xyz;
    u_xlat0.x = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat1.xyz * (-u_xlat0.xxx) + (-u_xlat2.xyz);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _GlassFlashing_ST;
uniform 	vec4 _FlashColor;
uniform 	float _MatcapBrightness;
uniform 	float _GlassColorExp;
uniform 	vec4 _GlassColor;
uniform 	float _CubeMapBrightness;
uniform 	float _ReflectionIntensity;
uniform 	vec4 _TransmissionColor;
uniform 	float _TransmissionIntencity;
uniform 	float _CenterTransparency;
uniform 	float _TransparencyExp;
uniform 	float _GlassTransparency;
uniform lowp sampler2D _GlassFlashing;
uniform lowp sampler2D _MatcapTex;
uniform lowp samplerCube _CubeMap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump float u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_11;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.y;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat16_21 = (-u_xlat7.x) + 1.0;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21;
    u_xlat7.x = log2(u_xlat18);
    u_xlat18 = max(u_xlat18, _CenterTransparency);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _TransparencyExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat2.w = u_xlat18 * _GlassTransparency;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat7.x * _GlassColorExp;
    u_xlat18 = exp2(u_xlat18);
    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_7 = inversesqrt(u_xlat16_7);
    u_xlat7.xyz = vec3(u_xlat16_7) * vs_TEXCOORD1.xyz;
    u_xlat10_7.xyz = texture(_CubeMap, u_xlat7.xyz).xyz;
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_CubeMapBrightness);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat7.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_ReflectionIntensity, _ReflectionIntensity, _ReflectionIntensity));
    u_xlat7.xyz = vec3(u_xlat18) * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vs_TEXCOORD2.xx + u_xlat4.xy;
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vs_TEXCOORD2.zz + u_xlat4.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_4.xyz = texture(_MatcapTex, u_xlat4.xy).xyz;
    u_xlat7.xyz = u_xlat10_4.xyz * vec3(_MatcapBrightness) + u_xlat7.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _GlassFlashing_ST.xy + _GlassFlashing_ST.zw;
    u_xlat4.xy = u_xlat4.xy + vec2(-0.109999999, 0.0);
    u_xlat10_18 = texture(_GlassFlashing, u_xlat4.xy).x;
    u_xlat7.xyz = vec3(u_xlat10_18) * _FlashColor.xyz + u_xlat7.xyz;
    u_xlat16_5 = max(u_xlat7.y, u_xlat7.x);
    u_xlat16_5 = max(u_xlat7.z, u_xlat16_5);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11.x = (-u_xlat16_5) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11.x = min(max(u_xlat16_11.x, 0.0), 1.0);
#else
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = (-u_xlat7.xyz) + u_xlat16_11.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_21) * u_xlat16_11.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_11.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, 0.100000001);
    u_xlat0.x = u_xlat0.x * 6.00012016;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat7.xyz * vec3(u_xlat16_5) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat16_3.x = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = max((-u_xlat16_3.x), 0.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat0.xyz = _TransmissionColor.xyz * vec3(_TransmissionIntencity);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat7.xyz * u_xlat16_3.xyz;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    SV_Target0.xyz = u_xlat7.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}